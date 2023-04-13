//
//  ChatsView.swift
//  TerpExchange
//
//  Created by kushal on 3/23/23.
//

import SwiftUI
let dateFormatter = DateFormatter();

class chatObj: Identifiable {
    var id = UUID()
    var name: String
    var product: Image
    var recentText: String
    var date: Date
    
    init(name: String, image: Image, recentText: String, date: Date) {
        self.name = name
        self.product = image
        self.recentText = recentText
        self.date = date
    }
}

struct chatView: View {
    func displayDate(date: Date) -> String{
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = "h:mm a"
        } else {
            dateFormatter.dateFormat = "MM/dd/yyyy"
        }
        return dateFormatter.string(from: Date())
    }
    var chatObject: chatObj
    var body: some View {
        VStack{
            HStack{
                HStack{
                    chatObject.product
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                    VStack{
                        HStack{
                            Text(chatObject.name.count > 20 ? "\(chatObject.name.prefix(20))..." : (chatObject.name))
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(displayDate(date: Date()))
                                .font(.system(size: 13))
                        }
                        .offset(y: -10)
                        
                        Text(chatObject.recentText.count > 80 ? "\(chatObject.recentText.prefix(80))..." : (chatObject.recentText + "\n"))
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
    @State var chats = [
        chatObj(name: "name",
                image: Image("rubix"),
                recentText: "recent text" ,
                date: Date()
               ),
        chatObj(name: "Lorem Ipsum is simply dummy text",
                image: Image("google"),
                recentText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry, Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book." ,
                date: Date()
               )
    ]
    
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                Text("Inbox")
                    .fontWeight(.heavy)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 20, y: 0)
                    .padding(.bottom, 20)
                List{
                    ForEach(chats, id: \.id){ chat in
                        NavigationLink(destination: DetailedChatView(chat: chat)){
                            chatView(chatObject: chat)
                        }
                    }
                    .onDelete(perform: removeChat)
                }
                .listStyle(.plain)
                .navigationBarHidden(true)
                .navigationTitle("Inbox")
            }
        }
    }
    
    func removeChat(at offsets: IndexSet){
        chats.remove(atOffsets: offsets)
    }
}

//struct ChatView_Previews: PreviewProvider {
//    @Binding var showTabBar: Bool
//
//    static var previews: some View {
//        ChatsView(showTabBar:)
//    }
//}
