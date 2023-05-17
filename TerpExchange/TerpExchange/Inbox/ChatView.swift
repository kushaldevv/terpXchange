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
    @State private var showFullImage = false
    
    var body: some View {
        ZStack{
            VStack(alignment: message.fromID == userID ? .trailing : .leading) {
                if message.text.starts(with: "https://firebasestorage.googleapis.com:443/v0/b/terpexchange-ab6a8.appspot.com") {
                    Button(action: {
                        showFullImage.toggle()
                    }, label: {
                        VStack{
                            AsyncImage(url: URL(string: message.text)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 250, height: 250)
                            .cornerRadius(20)
                        }
                        .frame(alignment: message.fromID == userID ? .trailing: .leading)
                    })
                    
                } else {
                    Button(action: {
                        showTime.toggle()
                    }, label: {
                        HStack{
                            if showTime && message.fromID != userID{
                                Text(displayDate(date: message.timestamp))
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                    .padding(message.fromID == userID ? .trailing : .leading, 10)
                                
                            }
                            Text(message.text)
                                .padding()
                                .background(message.fromID == userID ? redColor.gradient: Color.gray.opacity(0.65).gradient)
                                .cornerRadius(30)
                                .frame(maxWidth: 300, alignment: message.fromID == userID ? .trailing: .leading)
                            
                            if showTime && message.fromID == userID{
                                Text(displayDate(date: message.timestamp))
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                    .padding(message.fromID == userID ? .trailing : .leading, 10)
                                
                            }
                        }
                    })
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, alignment: message.fromID == userID ? .trailing : .leading)
            .padding(message.fromID == userID ? .trailing : .leading, 10)
        }
        .sheet(isPresented: $showFullImage){
            VStack{
                AsyncImage(url: URL(string: message.text)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .cornerRadius(20)
            }
            .frame(width: .infinity, height: .infinity)
//            .presentationBackground(.thinMaterial)
        }
    }
}

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var name: String
    @Binding var pfp : String
    @Binding var messageID: String
    @Binding var itemImage: String
    @StateObject var messagesManager: MessagesManager
    @StateObject var photoManager = PhotoManager()
    @StateObject var itemsDB = UserItemsDB()
    
    init(messageID: Binding<String>, name: Binding<String>, pfp: Binding<String>, itemImage: Binding<String>) {
        self._messageID = messageID
        self._name = name
        self._pfp = pfp
        self._itemImage = itemImage
        self._messagesManager = StateObject(wrappedValue: MessagesManager(chatID: messageID.wrappedValue))
    }
    
    @State private var messageText = ""
    @State private var selectPhoto = false
    @State private var selectedImage = UIImage()
    @State private var showImageAlert = false
    @State private var selectedImages: [UIImage] = []
    
    
    var body: some View {
        VStack {
            VStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(.black)
                }
                .frame(width: 36, height: 36)
                .background(.white)
                .clipShape(Circle())
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                let startIndex = messageID.index(messageID.startIndex, offsetBy: 28)
                let endIndex = messageID.index(messageID.startIndex, offsetBy: 55)
                let sellerID = String(messageID[startIndex...endIndex])
                
                if let currItem = itemsDB.fetchItem(userid: sellerID, itemid: String(messageID.suffix(36))) {
                    TitleRow(name: name, imageUrl: URL(string: pfp)!, itemImage: URL(string: itemImage)!, item: Item(id: currItem.id, userID: sellerID, image: currItem.image, title: currItem.title, description: currItem.description, price: currItem.price, category: currItem.category))
                        .offset(y: -10)
                        .padding(.top, 2)
                        .padding(.bottom, -10)
                }
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            messageBubble(message : message)
                        }
                    }
                    .frame(width: screenWidth)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                    .background(Color.white)
                    .cornerRadius(20)
                    .onChange(of: messagesManager.lastMessageId) { id in
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            .background(redColor)
            HStack {
                Button {
                    selectPhoto = true
                } label: {
                    Image(systemName: "photo.fill")
                        .foregroundColor(redColor)
                }
                .font(.system(size: 26))
                .padding(.leading, 10)
                if selectedImage == UIImage(){
                    TextField("Type something", text: $messageText)
                        .padding()
                        .onSubmit {
                            submitMessage()
                        }
                } else {
                    HStack{
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .overlay(alignment: .topTrailing){
                                Button(action: {
                                    selectedImage = UIImage()
                                }){
                                    Image(systemName: "xmark")
                                        .font(.system(size: 14))
                                        .bold()
                                        .foregroundColor(.black)
                                }
                                .frame(width: 30, height: 30)
                                .background(.white)
                                .clipShape(Circle())
                                .padding(.leading)
                                .offset(x: -10, y: 10)
                            }
                            .frame(height: 175)
                    }
                    .frame(width: screenWidth - 170)
                    .padding()
                }
                Button {
                    submitMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(redColor)
                }
                .font(.system(size: 26))
                .padding(.trailing, 10)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .background(Color.white)
            .padding(.vertical, -47)
        }
        .sheet(isPresented: $selectPhoto) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage, selectedImages: $selectedImages)
        }
    }
    
    func submitMessage(){
        if selectedImage != UIImage() {
            let path = "chats/" + messageID
            let resizedImage = selectedImage.aspectFittedToHeight(200)
            photoManager.upload(path: path, image: resizedImage) { imageURL in
                if let imageURL = imageURL {
                    messagesManager.sendMessage(messageID: messageID, text: imageURL)
                    selectedImage = UIImage()
                } else {
                    print ("error getting imageURL")
                }
            }
        } else {
            if messageText.count > 0 {
                messagesManager.sendMessage(messageID: messageID, text: messageText)
                messageText = ""
            }
        }
    }
}

