//
//  ChatsView.swift
//  TerpExchange
//
//  Created by kushal on 3/23/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

let dateFormatter = DateFormatter();

struct chatPreview: View {
    var chat: Chat
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Rectangle()
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
//                    chatObject.product
//                        .resizable()
//                        .frame(width: 70, height: 70)
//                        .clipShape(Rectangle())
//                        .cornerRadius(10)
                    VStack{
                        HStack{
                            Text(chat.name.count > 20 ? "\(chat.name.prefix(20))..." : (chat.name))
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(displayDate(date: chat.recentTextDate))
                                .font(.system(size: 13))
                        }
                        .offset(y: -10)

                        Text(chat.recentText.count > 80 ? "\(chat.recentText.prefix(80))..." : (chat.recentText + "\n"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 13))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}



struct ChatsView: View {
    @StateObject var inboxManager = InboxManager()
    @State var text = "Inbox"
    @State private var showSecondView = false
    @State private var currChat : Chat = Chat(messageID: "uniqddueID", name: "Test", pfp: "x", recentText: "x", recentTextDate: Date())

    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                Text(text)
                    .fontWeight(.heavy)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 20, y: 0)
                    .padding(.bottom, 20)
                List{
                    ForEach(inboxManager.chats, id: \.id){ chat in
                        Button(action: {
                            self.currChat = chat
                            self.showSecondView = true
                        }) {
                            chatPreview(chat: chat)
                        }
                    }
                    .onDelete(perform: removeChat)
                }
                .listStyle(.plain)
                .navigationBarHidden(true)
                .navigationTitle("Inbox")
            }
            .fullScreenCover(isPresented: $showSecondView,content: {
                ChatView(messageID: self.$currChat.messageID, name: self.$currChat.name, pfp: self.$currChat.pfp)
            })
        }
    }

    func removeChat(at offsets: IndexSet){
//        chats.remove(atOffsets: offsets)
    }
}
