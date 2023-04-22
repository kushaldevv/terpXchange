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
    var output = "hi"
    let userDocRef = db.collection("users").document(id)
    
    userDocRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let data = document.data()
            output = data?["displayName"] as? String ?? "error"
//            print(output)
        }
        else {
            print("Document does not exist")
        }
    }
    return output
}

func getPFP (id: String) -> URL{
    var output = ""
    db.collection("users").document(id).getDocument { (document, error) in
        if let document = document, document.exists {
            if let photoURL = document.get("photoURL") as? String {
                output = photoURL
            } else {
                print("photoURL field not found")
            }
        } else {
            print("Document not found")
        }
    }
//    print(output)
    return URL(string: output) ?? placeholder!
}



    

