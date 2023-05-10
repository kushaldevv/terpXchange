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
import FirebaseFunctions

struct ReviewsView: View {
    let currUserId: String
    @State var isAddingReview = false
    @StateObject var reviewsDB: ReviewsDB
    @ObservedObject var userItemsDB = UserItemsDB()
    
    @State var reviewArray = [Review]()
    
    init(currUserId: String) {
        self.currUserId = currUserId
        self._reviewsDB = StateObject(wrappedValue: ReviewsDB(useridd: currUserId))
    }

    var body: some View {

            
            VStack {
                ReviewsList(reviews: $reviewsDB.reviews)
//                ReviewsList(reviews: $reviewArray)
                
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
//                    AddReviewView(theCurrUserID: currUserId, currArr: $reviewsDB.reviews)
                    AddReviewView(theCurrUserID: currUserId, currArr: $reviewsDB.reviews)

                }
                
            }
            .onAppear {
                reviewsDB.fetchReviews(userid: currUserId)
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
    @StateObject var reviewsDB: ReviewsDB

    @State private var isPosted = false

    @State private var responseText = "Review Posted"

    var theCurrUserID: String
    @Binding var currArr: [Review]
    
    init(theCurrUserID: String, currArr: Binding<[Review]>) {
        self.theCurrUserID = theCurrUserID
        self._reviewsDB = StateObject(wrappedValue: ReviewsDB(useridd: theCurrUserID))
        self._currArr = currArr
    }
    
    var body: some View {
        VStack {
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
            
            
            Button(action: {
                let isReviewAdded = reviewsDB.addReview(rating: rating, details: details, theCurrUserID: theCurrUserID, currArr: currArr)
                isPosted = true
                if !isReviewAdded {
                    responseText = "No Self / Duplicate Reviews"
                } else {
                    responseText = "Review Posted!"
                    reviewsDB.fetchReviews(userid: theCurrUserID)
                }
            }) {
                Text("Save")
                    .foregroundColor(.blue)
            }
            
//            Button(action: {
//                let isReviewAdded = reviewsDB.addReview(rating: rating, details: details, theCurrUserID: theCurrUserID, currArr: currArr)
//                isPosted = true
//                if !isReviewAdded {
//                    responseText = "No Self / Duplicate Reviews"
//                } else {
//                    responseText = "Review Posted!"
//                    reviewsDB.fetchReviews(userid: theCurrUserID)
//                }
//            }) {
//                Text("Save")
//                    .foregroundColor(.blue)
//            }
            .alert(isPresented: $isPosted) {
                Alert(title: Text(responseText), dismissButton: .default(Text("OK")
//                                                                         , action: {
//                    reviewsDB.fetchReviews(userid: theCurrUserID)
//                }
                                                                        ))
            }
            .disabled(rating == 0)
        }
    }

}



//struct AddReviewView: View {
//    @State private var rating: Double = 3
//    @State private var details: String = ""
//    @ObservedObject private var reviewsDB = ReviewsDB()
//
//    @State private var isPosted = false
//
//    @State private var responseText = "Review Posted"
//
//    var theCurrUserID: String
//    @Binding var currArr: [Review]
//    var body: some View {
//
//        NavigationView {
//            Form {
//                Section(header: Text("Rating")) {
//                    HStack {
//                        Text("Select a rating:")
//                        Spacer()
//                        Stepper(value: $rating, in: 1...5, step: 1) {
//                            Text("\(Int(rating))")
//                                .foregroundColor(.black)
//                                .frame(width: 30, height: 30)
//                                .background(Color.yellow)
//                                .cornerRadius(15)
//                        }
//                    }
//                }
//                Section(header: Text("Review")) {
//                    TextEditor(text: $details)
//                        .frame(minHeight: 100)
//                        .padding(.vertical, 8)
//                }
//            }
//            .navigationBarTitle(Text("Add Review"), displayMode: .inline)
//            .navigationBarItems(trailing:
//                Button(action: {
//                let isReviewAdded = reviewsDB.addReview(rating: rating, details: details, theCurrUserID: theCurrUserID, currArr: currArr)
//                isPosted = true
//                    if !isReviewAdded {
//                        responseText = "No Self / Duplicate Reviews"
//                    } else {
//                        responseText = "Review Posted!"
//                    }
//                }) {
//                    Text("Save")
//                        .foregroundColor(.blue)
//                }
//                .alert(isPresented: $isPosted) {
//                       Alert(title: Text(responseText), dismissButton: .default(Text("OK"), action: {
//                           reviewsDB.fetchReviews(userid: theCurrUserID)
//                       }))
//                   }
//                   .disabled(rating == 0)
////                .alert(isPresented: $isPosted) {
////                    Alert(title: Text(responseText), dismissButton: .default(Text("OK")))
////                }
////                .disabled(rating == 0)
//            )
//        }
//        .onDisappear {
//                    if responseText == "Review Posted!" {
//                        // update reviewArray with the new review
//                        reviewsDB.fetchReviews(userid: theCurrUserID)
//                    }
//                }
//    }
//}

//struct ReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsView(currUserId: "user123",
//                    reviewArray: [Review(id: "review1", rating: 4, details: "Great experience!", timestamp: Date(), reviewerUID: "user456", reviewerName: "John", reviewerPhotoURL: URL(string: "https://example.com/john.jpg"))
//        ])
//
////        ReviewsView(currUserId: "currUserId", reviewArray: [Review])
//    }
//}
