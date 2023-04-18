////
////  ReviewsDB.swift
////  TerpExchange
////
////  Created by David Do on 4/9/23.
////
//
//import Foundation
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//
////struct Message {
////    var senderID : String
////    var recepientID: String
////    var message: String
////    var timestamp = Timestamp()
////}
//
//struct Chat: Identifiable {
//    var id = UUID()
//    var chatID: String
//    var users: [String]
//    var messages: [Message]
//    var recentMessage: String
////    var recentMessageTime: Timestamp
//}
//
//class InboxDB: ObservableObject {
//    @ObservedObject private var firebaseAuth = FirebaseAuthenticationModel()
//    let db = Firestore.firestore()
//    @Published var chats: [Chat] = []
//
//
//    func sendMessage(chatID: String, message : Message) {
//        let chatDocRef = db.collection("chats").document(chatID)
//        chatDocRef.updateData(["messages": FieldValue.arrayUnion([
//                [
//                    "senderID": message.senderID,
//                    "recepientID": message.recepientID,
//                    "message": message.message,
//                    "timestamp": message.timestamp
//                ]
//        ])])
//
//        chatDocRef.updateData(["recentMessage": message.message])
//
//        if let user = firebaseAuth.getCurrentUser() {
//            let usersRef = db.collection("users").document(user.uid)
//            fetchChats(usersRef)
//        }
//    }
//
//    func fetchChats(_ userRef: DocumentReference){
//        userRef.getDocument { document, error in
//            if let error = error {
//                print("Error getting user document: \(error.localizedDescription)")
//                return
//            }
//            guard let document = document, document.exists else {
//                print("User document doesn't exist")
//                return
//            }
//
//            let data = document.data()
//
//            guard let chatIDs = data?["chats"] as? [String] else {
//                print("Error getting chats")
//                return
//            }
//            var chatsArray: [Chat] = []
//            for chatID in chatIDs {
//                let chatDocRef = self.db.collection("chats").document(chatID)
//                chatDocRef.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        let usersArray = document.get("users") as? [String] ?? []
//                        let messagesArray = document.get("messages") as? [[String: Any]] ?? []
//                        var messages: [Message] = []
//                        for messageData in messagesArray {
//                            if let senderID = messageData["senderID"] as? String,
//                               let recepientID = messageData["recepientID"] as? String,
//                               let messageText = messageData["message"] as? String,
//                               let timestamp = messageData["timestamp"] as? Timestamp
//                            {
//                                let message = Message(senderID: senderID, recepientID: recepientID, message: messageText, timestamp: timestamp)
//                                messages.append(message)
//                            }
//                        }
//                        let recentMessage = document.get("recentMessage") as? String ?? ""
//                        let recentMessageTime = document.get("recentMessageTime") as? Timestamp ?? Timestamp()
//
//                        let chat = Chat(chatID: chatID, users: usersArray, messages: messages, recentMessage: recentMessage)
//                        chatsArray.append(chat)
//                    }
//                }
//            }
//            self.chats = chatsArray
//        }
//        print("Done Fetching")
//    }
//}
