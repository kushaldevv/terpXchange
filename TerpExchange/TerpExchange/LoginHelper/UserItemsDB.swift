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
    var id: String
    let userID: String
    let image: [String]
    var timestamp:  Date
    let title: String
    let description: String
    let price: Double
    let category: String
    
    init(id: String, userID: String, image: [String], title: String, description: String, price: Double, category: String) {
        self.id = id
        self.userID = userID
        self.image = image
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.timestamp = Date() // Provide an initial value for the `timestamp` property
    }
    
//    func updateID(id: UUID) {
//        self.id = id
//    }
    
    func updateTimestamp(timestamp: Date) {
        self.timestamp = timestamp
    }
}

class UserItemsDB: ObservableObject {
    
    @ObservedObject private var firebaseAuth = FirebaseAuthenticationModel()
    
    let db = Firestore.firestore()
    @Published var userItems: [Item] = []
    @Published var specificItems: [Item] = []
    
    
    func addItem(price: Double, description: String, title: String, images: [String], category: String) {
        if let user = firebaseAuth.getCurrentUser() {
            let usersRef = db.collection("users").document(user.uid)
            print("ARE YOU HERE")
            usersRef.updateData(["items": FieldValue.arrayUnion([
                [
                    "id": UUID().uuidString,
                    "userID": user.uid,
                    "title": title,
                    "description": description,
                    "category": category,
                    "price": price,
                    "timestamp": Timestamp(),
                    "image": images
                ]
            ])]) { error in
                if let error = error {
                    print("Error adding item to database: \(error.localizedDescription)")
                } else {
                    print("Item added to database.")
                    
                    //let newItem = Item(userID: user.uid, image: Image(systemName: "photo"), title: title, description: description, price: price)
                    //self.userItems.append(newItem)
                }
            }
        }
    }
    
    func fetchItems(){
        self.userItems = []
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    if let items = data["items"] as? [[String: Any]] {
                        for item in items {
                            let description = item["description"] as? String ?? ""
                            let price = item["price"] as? Double ?? 0.0
                            let id = item["id"] as? String ?? UUID().uuidString
                            let timestamp = item["timestamp"] as? Timestamp
                            let title = item["title"] as? String ?? ""
                            let userID = item["userID"] as? String ?? ""
                            let images = item["image"] as? [String] ?? []
                            let category = item["category"] as? String ?? ""
                            let curr = Item(id: id, userID: userID, image: images.reversed(), title: title, description: description, price: price, category: category)
//                            curr.updateID(id: id)
                            curr.updateTimestamp(timestamp: timestamp?.dateValue() ?? Date())
                            self.userItems.append(curr)
                        }
                    }
                }
            }
            
        }
    }
    
    func fetchSpecificUserItems(userid: String){
        let usersRef = db.collection("users").document(userid)
        
        usersRef.addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                let items = data?["items"] as? [[String: Any]] ?? []
                self.specificItems = []
                for item in items {
                    let description = item["description"] as? String ?? ""
                    let price = item["price"] as? Double ?? 0.0
                    let id = item["id"] as? String ?? UUID().uuidString
                    let timestamp = item["timestamp"] as? Timestamp
                    let title = item["title"] as? String ?? ""
                    let images = item["image"] as? [String] ?? []
                    let category = item["category"] as? String ?? ""
                    let curr = Item(id: id, userID: userID, image: images.reversed(), title: title, description: description, price: price, category: category)
                    curr.updateTimestamp(timestamp: timestamp?.dateValue() ?? Date())
                    self.specificItems.append(curr)
                }
            }
            else {
                print(userid)
                print("Document does not exist")
            }
        }
    }
    
    func fetchItem(userid: String, itemid: String) -> Item?{
        fetchSpecificUserItems(userid: userid)
        for item in specificItems {
            if item.id == itemid {
                return item
            }
        }
        return nil
    }
    
}


