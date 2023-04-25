//
//  InboxManager.swift
//  TerpExchange
//
//  Created by kushal on 4/17/23.
//

//import Foundation
//import FirebaseFirestore
//import SwiftUI

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class MessagesManager: ObservableObject {
    @Published private (set) var messages: [Message] = []
    @Published private(set) var lastMessageId: UUID = UUID()
    
    let db = Firestore.firestore()
    
    init(chatID: String){
        getMessages(chatID: chatID)
    }
    
    func getMessages(chatID : String) {
        db.collection("chats").document(chatID).addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                if let messagesData = document.get("messages") as? [[String: Any]] {
                    self.messages = messagesData.compactMap { data in
                        let timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
                        return Message(fromID: data["fromID"] as? String ?? "",
                                       text: data["text"] as? String ?? "",
                                       timestamp: timestamp.dateValue()
                        )
                    }
                } else{
                    print("messagesData error")
                }
            } else {
                print("Document \(chatID) does not exist")
            }
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    func sendMessage(messageID: String, text: String) {
        let chatDocRef = db.collection("chats").document(messageID)
        chatDocRef.updateData([
            "recentText": text,
            "recentTextTime": Timestamp(),
            "messages": FieldValue.arrayUnion([
                [
                    "fromID": userID,
                    "text": text,
                    "timestamp": Timestamp(),
                ]
            ])]) { error in
                if let error = error {
                    print("Error adding message to database: \(error.localizedDescription)")
                } else {
                    print("message added to database.")
                }
            }
    }
}
