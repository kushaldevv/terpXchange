//
//  FirestoreDB.swift
//  TerpExchange
//
//  Created by David Do on 4/8/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class FirestoreDB: ObservableObject {
    
    @ObservedObject private var firebaseAuth = FirebaseAuthenticationModel()
    
    // Store user ID in Firestore
    let db = Firestore.firestore()
    
    func saveUserIdToFirestore() {
        if let user = firebaseAuth.getCurrentUser() {
            let usersRef = db.collection("users").document(user.uid)

            usersRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    // User already exists, do nothing
                    print("User already exists")
                } else {
                    // User does not exist, create new document
                    let data: [String: Any] = [
                        "userId": user.uid,
                        "displayName": user.displayName ?? "",
                        "email": user.email ?? "",
                        "photoURL": user.photoURL?.absoluteString ?? "",
                        "reviews": []
                    ]

                    usersRef.setData(data) { error in
                        if let error = error {
                            print("Error saving user ID to database: \(error.localizedDescription)")
                        } else {
                            print("User ID saved to database")
                        }
                    }
                }
            }
        }
    }

}

