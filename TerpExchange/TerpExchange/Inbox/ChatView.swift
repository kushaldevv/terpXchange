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
    @Environment(\.presentationMode) var presentationMode
    @Binding var messageID : String
    @Binding var name: String
    @Binding var pfp : String
    @StateObject var messagesManager = MessagesManager(chatID: "uniqueID")
    @State var messageText = ""
    
    var body: some View {
        VStack {
            VStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.system(size: 25))
                })
                .frame(width: 25, height: 25)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: 20)
                
                TitleRow(name: name, imageUrl: URL(string: pfp)!)
                    .background(Color("CoralPink"))
                    .offset(y: -10)
                    .padding(.bottom, -10)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            messageBubble(message : message)
                        }
                        
                    }
                    .frame(width: screenWidth)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .background(Color.white)
                    .cornerRadius(20)
                    .onChange(of: messagesManager.lastMessageId) { id in
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
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
        }
    }
}
