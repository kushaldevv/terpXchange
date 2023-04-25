//
//  InboxManager.swift
//  TerpExchange
//
//  Created by kushal on 4/17/23.
//

import Foundation
import FirebaseFirestore

struct Chat {
    var id = UUID()
    var messageID : String
    var name: String
    var pfp: String
    var recentText: String
    var recentTextDate: Date
}

class InboxManager: ObservableObject {
    @Published private (set) var chats: [Chat] = []
    private var chatIDs : [String] = []
    
    init(){
        getChatIDs()
    }
    
    func getChatIDs(){
        let userDocRef = db.collection("users").document(userID)
        userDocRef.addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                self.chatIDs = document.get("chats") as? [String] ?? []
                self.getChatDetails()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func getChatDetails(){
        let chatsCollection = db.collection("chats")
        var recentText = ""
        var recentTextTime = Timestamp()
        for id in chatIDs{
            let chatsCollectionRef = chatsCollection.document(id)
            chatsCollectionRef.addSnapshotListener { (document, error) in
                if let document = document, document.exists {
                    let usersArray = document.data()?["users"] as? [[String: [String: String]]] ?? []
                    recentText =  document.data()?["recentText"] as? String ?? "recent text"
                    recentTextTime = document.data()?["recentTextTime"] as? Timestamp ?? Timestamp()
                    var newChats : [Chat] = []
                    for user in usersArray {
                        for (userId, userData) in user {
                            if userId != userID {
                                let name = userData["name"] ?? "Unknown"
                                let pfp = userData["pfp"] ?? "https://example.com/default.png"
                                
                                newChats.append(Chat(messageID: id, name: name, pfp: pfp, recentText: recentText, recentTextDate: recentTextTime.dateValue()))
                            }
                        }
                    }
                    self.chats = newChats
                } else {
                    print("Document does not exist")
                }
            }
            
        }
    }
}
