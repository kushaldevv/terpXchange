//
//  ReviewsView.swift
//  TerpExchange
//
//  Created by David Do on 4/2/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseCore

struct ReviewsView: View {

    @State var isAddingReview = false
    @State var reviews: [Review] = []

    var body: some View {
        VStack {
            ReviewsList(reviews: reviews)

            
            Button(action: { isAddingReview = true }) {
                Text("Add a Review")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            .sheet(isPresented: $isAddingReview) {
                AddReviewView()
            }
        }
    }
    
}

struct Review: Identifiable {
    var id: String
    var rating: Int
    var details: String
    var timestamp: Date
    var reviewerUID: String
    var reviewerName: String
}

struct ReviewsList: View {
    @State var reviews: [Review] = []

    var body: some View {
        List(reviews, id: \.id) { review in
            VStack(alignment: .leading) {
                Text("\(review.reviewerName) gave it \(review.rating) stars")
                    .font(.headline)
                Text(review.details)
                    .font(.subheadline)
                Text(review.timestamp, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            let db = Firestore.firestore()
            let userId = Auth.auth().currentUser?.uid ?? ""
            let userRef = db.collection("users").document(userId)

            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let reviews = data?["reviews"] as? [[String: Any]] ?? []
                    for reviewData in reviews {
                        if let rating = reviewData["rating"] as? Int,
                           let details = reviewData["details"] as? String,
                           let timestamp = reviewData["timestamp"] as? Timestamp,
                           let reviewerUID = reviewData["reviewerUID"] as? String,
                           let reviewerName = reviewData["reviewerName"] as? String {
                            let review = Review(id: UUID().uuidString, rating: rating, details: details, timestamp: timestamp.dateValue(), reviewerUID: reviewerUID, reviewerName: reviewerName)
                            self.reviews.append(review)
                        }
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}

struct AddReviewView: View {
    @State private var rating: Double = 3
    @State private var details: String = ""
    @State private var reviewerUID: String = ""
    @State private var reviewerName: String = ""
    @State var isReviewPosted = false
    
    let usersRef: DocumentReference
    
    init() {
        guard let userId = Auth.auth().currentUser?.uid else {
            fatalError("User is not signed in")
        }
        self.usersRef = Firestore.firestore().collection("users").document(userId)
        self.reviewerUID = usersRef.documentID
        self.reviewerName = Auth.auth().currentUser?.displayName ?? "Unknown"
        }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rating")) {
                    HStack {
                        Text("Select a rating:")
                        Spacer()
                        Stepper(value: $rating, in: 1...5, step: 1) {
                            Text("\(Int(rating))")
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                                .background(Color.yellow)
                                .cornerRadius(15)
                        }
                    }
                }
                Section(header: Text("Review")) {
                    TextEditor(text: $details)
                        .frame(minHeight: 100)
                        .padding(.vertical, 8)
                }
            }
            .navigationBarTitle(Text("Add Review"), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    // Save review to database
                    let reviewerUID = Auth.auth().currentUser?.uid ?? ""
                    let reviewerName = Auth.auth().currentUser?.displayName ?? "Unknown"
                    usersRef.updateData(["reviews": FieldValue.arrayUnion([
                        [
                            "rating": rating,
                            "details": details,
                            "timestamp": Timestamp(),
                            "reviewerUID": reviewerUID,
                            "reviewerName": reviewerName
                        ]
                    ])])
                    isReviewPosted = true
                }) {
                    Text("Save")
                }.alert(isPresented: $isReviewPosted) {
                    Alert(
                        title: Text("Review Posted!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding()

            )
        }
    }
}


struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
