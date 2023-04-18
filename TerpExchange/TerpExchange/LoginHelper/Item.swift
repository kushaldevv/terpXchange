//
//  Item.swift
//  TerpExchange
//
//  Created by kushal on 4/14/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class Item {
        let id: UUID
        let userID: String
        let image: Image
        let date:  Date
        let title: String
        let description: String
        let price: Double
    
        init(userID: String, image: Image, title: String, description: String, price: Double) {
            self.id = UUID()
            self.userID = userID
            self.image = image
            self.date = Date()
            self.title = title
            self.description = description
            self.price = price
        }
    
//    init(title: String) {
//        self.title = title
//    }
}





class ItemsDB: ObservableObject {
    
    @ObservedObject private var firebaseAuth = FirebaseAuthenticationModel()
    
    let db = Firestore.firestore()
    @Published var items: [Item] = []
    
//    func addItem(item:item) {
//        if let user = firebaseAuth.getCurrentUser() {
//
//            let usersRef = db.collection("users").document(user.uid)
//            print(usersRef.debugDescription)
//            usersRef.updateData(["items": FieldValue.arrayUnion([
//                [
//                    //                    "id": item.id,
//                    //                    "id": "item.id",
//                    //                    "userID": item.userID,
//                    //                    "image": item.image,
//                    //                    "image": "item.image",
//                    //                    "date": item.date,
//                    //                    "date": Timestamp(),
//                    "title": item.title
//                    //                    ,
//                    //                    "description": item.description,
//                    //                    "price": item.price
//                ]
//            ])])
//            { error in
//                if let error = error {
//                    print("Error adding item to database: \(error.localizedDescription)")
//                } else {
//                    print("Item added to database.")
//                    //self.items.append(item)
//
//                }
//            }
//        }
//    }
    
    func getItems() -> [Item]{
        return items
    }
}


