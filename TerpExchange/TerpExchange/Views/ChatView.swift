//
//  ChatView.swift
//  TerpExchange
//
//  Created by kushal on 4/17/23.
//

import SwiftUI

struct messageBubble: View {
    var message: Message
    @State var showTime = false
    
    var body: some View {
        VStack(alignment: message.fromID == userID ? .trailing : .leading) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.fromID == userID ? Color("CoralPink"): Color.gray)
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.fromID == userID ? .trailing: .leading)
            .onTapGesture {
                showTime.toggle()
            }
            if showTime {
//                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                Text(displayDate(date: message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.fromID == userID ? .trailing : .leading, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.fromID == userID ? .trailing : .leading)
        .padding(message.fromID == userID ? .trailing : .leading, 10)
    }
}


struct ChatView: View {
    var messageID = "uniqueID"
    @StateObject var messagesManager = MessagesManager(chatID: "uniqueID")
    @State var messageText = ""
    
    var body: some View {
        NavigationView{
            VStack {
                VStack{
                    TitleRow()
                        .background(Color("CoralPink"))
                    
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            withAnimation{
                                messageBubble(message : message)
                            }
                        }

                    }
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .background(Color("CoralPink"))
                HStack {
                    TextField("Type something", text: $messageText)
                        .padding()
                        .onSubmit {
                            messagesManager.sendMessage(messageID: messageID, text: messageText)
                            messageText = ""
                        }
                    Button {
                        messagesManager.sendMessage(messageID: messageID, text: messageText)
                        messageText = ""
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color("CoralPink"))
                    }
                    .font(.system(size: 26))
                    .padding(.horizontal, 10)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                .background(Color.white)
                .padding(.vertical, -35)
//                .offset(y: -60)
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
    return dateFormatter.string(from: Date())
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
