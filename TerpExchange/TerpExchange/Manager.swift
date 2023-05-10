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
import SwiftUI

let screenSize: CGRect = UIScreen.main.bounds
let insets = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let coralPinkColor = Color("CoralPink")
let offwhiteColor = Color("offwhite")
let redColor = Color(red: 253.0/255.0, green: 138.0/255.0, blue: 138.0/255.0)

let db = Firestore.firestore()
var userID = Auth.auth().currentUser?.uid ?? "8A3nHOpWaGgAWsPC6Irf77E7tUC3"
var username = Auth.auth().currentUser?.displayName ?? "burner account"
let placeholder = URL(string: "https://firebasestorage.googleapis.com/v0/b/terpexchange-ab6a8.appspot.com/o/chats%2FuniqueID%2FIMG_2021.png?alt=media&token=f16d80b0-db5d-4738-974b-a2e64610b5ad")
var userPhotoURL = Auth.auth().currentUser?.photoURL ?? placeholder



func getUserProfile(id: String, completion: @escaping ([String : String]) -> Void) {
    var output = ["name": "", "pfp": ""]
    let userDocRef = db.collection("users").document(id)
    
    userDocRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let data = document.data()
            output["name"] = data?["displayName"] as? String ?? ""
            output["pfp"] = data?["photoURL"] as? String ?? ""
        }
        else {
            print("Document does not exist")
        }
        completion(output)
    }
}

func createChat(itemImage: String, sellerID: String, sellerName: String, sellerPFP: String, messageID: String){
    let docRef = db.collection("chats").document(messageID)
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            print("chat already exists")
            return
        } else {
            print("creating chat")
            let userDocRef = db.collection("users").document(userID)
            let sellerDocRef = db.collection("users").document(sellerID)
            userDocRef.updateData([
                "chats": FieldValue.arrayUnion([messageID])
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document updated successfully")
                }
            }
            sellerDocRef.updateData([
                "chats": FieldValue.arrayUnion([messageID])
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document updated successfully")
                }
            }
            
            let newChatData: [String: Any] = [
                "messages": [],
                "recentText": "",
                "recentTextTime": Timestamp(),
                "itemImage": itemImage,
                "users": [
                    [userID: [
                        "name": username,
                        "pfp": userPhotoURL?.absoluteString
                    ]],
                    [sellerID: [
                        "name": sellerName,
                        "pfp": sellerPFP
                    ]]
                ]
            ]
            
            let newChatDocRef = db.collection("chats").document(messageID)
            newChatDocRef.setData(newChatData, merge: true) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully")
                }
            }
        }
    }
}



func displayDate(date: Date) -> String{
    if Calendar.current.isDateInToday(date) {
        dateFormatter.dateFormat = "h:mm a"
    } else {
        dateFormatter.dateFormat = "MM/dd/yyyy"
    }
    return dateFormatter.string(from: date)
}
