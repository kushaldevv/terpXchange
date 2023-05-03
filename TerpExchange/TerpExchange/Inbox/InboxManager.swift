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
    var itemImage : String
    var messageID : String
    var name: String
    var pfp: String
    var recentText: String
    var recentTextDate: Date
}

class InboxManager: ObservableObject {
    @Published private (set) var chats: [Chat] = []
    private var chatIDs : [String] = []
    @Published private var existingChats : [String] = []
    
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
        var itemImage = ""
        var newChats : [Chat] = []
        
        for id in chatIDs{
            let chatsCollectionRef = chatsCollection.document(id)
            chatsCollectionRef.addSnapshotListener { (document, error) in
                if let document = document, document.exists {
                    let usersArray = document.data()?["users"] as? [[String: [String: String]]] ?? []
                    recentText =  document.data()?["recentText"] as? String ?? "recent text"
                    recentTextTime = document.data()?["recentTextTime"] as? Timestamp ?? Timestamp()
                    itemImage = document.data()?["itemImage"] as? String ?? ""
                    
                    for user in usersArray {
                        for (userId, userData) in user {
                            if userId != userID {
                                let name = userData["name"] ?? "Unknown"
                                let pfp = userData["pfp"] ?? "https://example.com/default.png"
                                
                                if (!self.existingChats.contains(id)) {
                                    newChats.append(Chat(itemImage: itemImage, messageID: id, name: name, pfp: pfp, recentText: recentText, recentTextDate: recentTextTime.dateValue()))
                                    self.chats = newChats.reversed()
                                    self.existingChats.append(id)
                                }
                                else {
                                    for i in 0..<self.chats.count {
                                        if (self.chats[i].messageID == id) {
                                            self.chats[i] = Chat(itemImage: itemImage, messageID: id, name: name, pfp: pfp, recentText: recentText, recentTextDate: recentTextTime.dateValue())
                                        }
                                    }
                                }
                                self.chats = self.chats.sorted(by: {$0.recentTextDate > $1.recentTextDate})
                            }
                        }
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
//        print(newChats)
//        self.chats = newChats
    }
}
