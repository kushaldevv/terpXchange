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

struct chatView: View {
//    var chat: Chat
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
//                        HStack{
//                            Text(chat.users[0].count > 20 ? "\(chat.users[0].prefix(20))..." : (chat.users[0]))
//                                .fontWeight(.bold)
//                                .font(.system(size: 15))
//                                .frame(maxWidth: .infinity, alignment: .leading)
//
//                            Text(displayDate(date: Date()))
//                                .font(.system(size: 13))
//                        }
//                        .offset(y: -10)
//
//                        Text(chat.recentMessage.count > 80 ? "\(chat.recentMessage.prefix(80))..." : (chat.recentMessage + "\n"))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .foregroundColor(Color.gray)
//                            .font(.system(size: 13))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}



struct ChatsView: View {
//    @ObservedObject var inboxDB = InboxDB()
//    @Binding var chats: [Chat]
    @State var text = "Inbox"
    
    @ObservedObject private var firebaseAuth = FirebaseAuthenticationModel()
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                Text(text)
                    .fontWeight(.heavy)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 20, y: 0)
                    .padding(.bottom, 20)
                Button("Click"){
                    if let user = firebaseAuth.getCurrentUser() {
                        text = String(user.uid)
                    } else {
                        text = "not logged in"
                    }
                }
                    
                List{
//                    ForEach(chats, id: \.id){ chat in
//                        NavigationLink(destination: DetailedChatView(chat: chat)){
//                            chatView(chat: chat)
//                        }
//                    }
//                    .onDelete(perform: removeChat)
                }
                .listStyle(.plain)
                .navigationBarHidden(true)
                .navigationTitle("Inbox")
            }
        }
    }
    
    func removeChat(at offsets: IndexSet){
//        chats.remove(atOffsets: offsets)
    }
}

//func displayDate(date: Date) -> String{
//    if Calendar.current.isDateInToday(date) {
//        dateFormatter.dateFormat = "h:mm a"
//    } else {
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//    }
//    return dateFormatter.string(from: Date())
//}
//struct ChatView_Previews: PreviewProvider {
//    @Binding var showTabBar: Bool
//
//    static var previews: some View {
//        ChatsView(showTabBar:)
//    }
//}
