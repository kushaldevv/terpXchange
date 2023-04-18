//
//  Manager.swift
//  TerpExchange
//
//  Created by kushal on 4/18/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

let db = Firestore.firestore()
let userID = Auth.auth().currentUser?.uid ?? "8A3nHOpWaGgAWsPC6Irf77E7tUC3"
let username = Auth.auth().currentUser?.displayName ?? "Unknown"
let placeholder = URL(string: "https://lh3.googleusercontent.com/a/AGNmyxZfOmqFAxm7HuQonfZV8H6qjBM3RX7TpJr-h-nq=s192-c-rg-br100")
let userPhotoURL = Auth.auth().currentUser?.photoURL ?? placeholder

func getName(id: String) -> String {
    return "test"
}
 
func getPFP (id: String) -> URL{
    var output = ""
    let userDocRef = db.collection("users").document(id)
    userDocRef.getDocument { (document, error) in
        if let document = document, document.exists {
             output = document.get("photoURL") as? String ?? ""
        } else {
            print("Document does not exist")
        }
    }
    return URL(string: output) ?? placeholder!
}
