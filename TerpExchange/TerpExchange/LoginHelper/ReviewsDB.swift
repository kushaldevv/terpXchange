//
//  ReviewsDB.swift
//  TerpExchange
//
//  Created by David Do on 4/9/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

struct Review {
    let id: String
    let rating: Int
    let details: String
    let timestamp: Date
    let reviewerUID: String
    let reviewerName: String
    let reviewerPhotoURL: URL?
}

class ReviewsDB: ObservableObject {
    
    @ObservedObject private var firebaseAuth = FirebaseAuthenticationModel()
    
    let db = Firestore.firestore()
    @Published var reviews: [Review] = []
    
    func addReview(rating: Double, details: String) {

        if let user = firebaseAuth.getCurrentUser() {
            
            let usersRef = db.collection("users").document(user.uid)
            
            usersRef.updateData(["reviews": FieldValue.arrayUnion([
                [
                    "rating": rating,
                    "details": details,
                    "timestamp": Timestamp(),
                    "reviewerUID": user.uid,
                    "reviewerName": user.displayName ?? "Unknown",
                    "reviewerPhotoURL": user.photoURL?.absoluteString
                ]
            ])]) { error in
                if let error = error {
                    print("Error adding review to database: \(error.localizedDescription)")
                } else {
                    print("Review added to database.")
                    self.reviews.append(Review(id: UUID().uuidString, rating: Int(rating), details: details, timestamp: Date(), reviewerUID: user.uid, reviewerName: user.displayName ?? "Unknown", reviewerPhotoURL: user.photoURL))
                }
            }
        }
    }
    
    func fetchReviews(userid: String) {
        let usersRef = db.collection("users").document(userid)
        
        usersRef.addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                let reviews = data?["reviews"] as? [[String: Any]] ?? []
                self.reviews = []
                for reviewData in reviews {
                    if let rating = reviewData["rating"] as? Int,
                       let details = reviewData["details"] as? String,
                       let timestamp = reviewData["timestamp"] as? Timestamp,
                       let reviewerUID = reviewData["reviewerUID"] as? String,
                       let reviewerName = reviewData["reviewerName"] as? String,
                       let reviewerPhotoURLString = reviewData["reviewerPhotoURL"] as? String,
                       let reviewerPhotoURL = URL(string: reviewerPhotoURLString) {
                        let review = Review(id: UUID().uuidString, rating: rating, details: details, timestamp: timestamp.dateValue(), reviewerUID: reviewerUID, reviewerName: reviewerName, reviewerPhotoURL: reviewerPhotoURL)
                        self.reviews.append(review)
                    }
                }
            }
            else {
                print("Document does not exist")
            }
        }
    }
    
    func averageRating(userId: String) -> Double {
        fetchReviews(userid: userId)
        if reviews.isEmpty {
            return 0
        } else {
            let totalRating = reviews.reduce(0, { $0 + $1.rating })
            let average = Double(totalRating) / Double(reviews.count)
            return Double(String(format: "%.1f", average)) ?? 0
        }
    }

    func numberOfReviews(userId: String) -> Int {
        fetchReviews(userid: userId)
        return reviews.count
    }
    
    
}
