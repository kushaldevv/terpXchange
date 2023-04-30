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

// 8A3nHOpWaGgAWsPC6Irf77E7tUC3
// mhBd9Q7zeuM0RJM4jn3zJlmeBDu1

let db = Firestore.firestore()
var userID = Auth.auth().currentUser?.uid ?? "mhBd9Q7zeuM0RJM4jn3zJlmeBDu1"
let username = Auth.auth().currentUser?.displayName ?? "Unknown"
let placeholder = URL(string: "https://firebasestorage.googleapis.com/v0/b/terpexchange-ab6a8.appspot.com/o/chats%2FuniqueID%2FIMG_2021.png?alt=media&token=f16d80b0-db5d-4738-974b-a2e64610b5ad")
let userPhotoURL = Auth.auth().currentUser?.photoURL ?? placeholder

//func getName(id: String) -> String {
//    var output = "hi"
//    let userDocRef = db.collection("users").document(id)
//
//    userDocRef.getDocument { (document, error) in
//        if let document = document, document.exists {
//            let data = document.data()
//            output = data?["displayName"] as? String ?? "error"
////            print(output)
//        }
//        else {
//            print("Document does not exist")
//        }
//    }
//    return output
//}

//func getPFP (id: String) -> URL{
//    var output = ""
//    db.collection("users").document(id).getDocument { (document, error) in
//        if let document = document, document.exists {
//            if let photoURL = document.get("photoURL") as? String {
//                output = photoURL
//            } else {
//                print("photoURL field not found")
//            }
//        } else {
//            print("Document not found")
//        }
//    }
////    print(output)
//    return URL(string: output) ?? placeholder!
//}

func displayDate(date: Date) -> String{
    if Calendar.current.isDateInToday(date) {
        dateFormatter.dateFormat = "h:mm a"
    } else {
        dateFormatter.dateFormat = "MM/dd/yyyy"
    }
    return dateFormatter.string(from: date)
}
