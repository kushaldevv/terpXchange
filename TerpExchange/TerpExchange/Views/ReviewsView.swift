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
    @ObservedObject var reviewsDB = ReviewsDB()
    @ObservedObject var userItemsDB = UserItemsDB()
    let currUserId: String
    @State var reviewArray = [Review]()

    var body: some View {

            
            VStack {
//                Text("\(reviewsDB.numberOfReviews(userId: userID)) reviews")
//                Text("\(reviewsDB.averageRating(userId: userID)) rating")
//                ReviewsList(reviews: $reviewsDB.reviews)
                ReviewsList(reviews: $reviewArray)
                
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
//            .navigationBarTitle(Text("Reviews"))
            .onAppear {
//                reviewsDB.fetchReviews(userid: currUserId)
            }
            
        
        
    }

}

struct ReviewsList: View {
    @Binding var reviews: [Review]
    
    var body: some View {
        if reviews.isEmpty {
            Text("No reviews yet.")
        } else {
            List(reviews, id: \.id) { review in
                VStack(alignment: .leading) {
                    NavigationLink(destination: UserProfileView(userName: review.reviewerName, userId: review.reviewerUID, userProfileURL: review.reviewerPhotoURL)) {
                        Text("\(review.reviewerName) gave it \(review.rating) stars")
                            .font(.headline)
                    }
                    .navigationBarTitle(Text("Back"), displayMode: .inline)
                    Text(review.details)
                        .font(.subheadline)
                    Text(review.timestamp, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct AddReviewView: View {
    @State private var rating: Double = 3
    @State private var details: String = ""
    @State var isReviewPosted = false
    @ObservedObject private var reviewsDB = ReviewsDB()
    
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
                    reviewsDB.addReview(rating: rating, details: details)
                    isReviewPosted = true
                }) {
                    Text("Save")
                        .foregroundColor(.blue) // add foreground color
                }.alert(isPresented: $isReviewPosted) {
                    Alert(
                        title: Text("Review Posted!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                //            .padding()
                
            )
            
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(currUserId: "user123",
                    reviewArray: [Review(id: "review1", rating: 4, details: "Great experience!", timestamp: Date(), reviewerUID: "user456", reviewerName: "John", reviewerPhotoURL: URL(string: "https://example.com/john.jpg"))
        ])

//        ReviewsView(currUserId: "currUserId", reviewArray: [Review])
    }
}
