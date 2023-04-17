//
//  UserItemsDB.swift
//  TerpExchange
//
//  Created by David Do on 4/16/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class Item {
    let id: UUID
    let userID: String
    let image: Image
    let timestamp:  Date
    let title: String
    let description: String
    let price: Double
    
    init(userID: String, image: Image, title: String, description: String, price: Double) {
        self.id = UUID()
        self.userID = userID
        self.image = image
        self.title = title
        self.description = description
        self.price = price
        self.timestamp = Date() // Provide an initial value for the `timestamp` property
    }
}

class UserItemsDB: ObservableObject {
    
    @ObservedObject private var firebaseAuth = FirebaseAuthenticationModel()
    
    let db = Firestore.firestore()
    @Published var userItems: [Item] = []
    
    
    func addItem(price: Double, description: String, title: String) {
            
        if let user = firebaseAuth.getCurrentUser() {
            
            let usersRef = db.collection("users").document(user.uid)
            
            usersRef.updateData(["items": FieldValue.arrayUnion([
                [
                    "id": UUID().uuidString,
                    "userID": user.uid,
                    "title": title,
                    "description": description,
                    "price": price,
                    "timestamp": Timestamp()
                ]
            ])]) { error in
                if let error = error {
                    print("Error adding item to database: \(error.localizedDescription)")
                } else {
                    print("Item added to database.")
                    
                    let newItem = Item(userID: user.uid, image: Image(systemName: "photo"), title: title, description: description, price: price)
                    self.userItems.append(newItem)
                }
            }
        }
    }

    
}
