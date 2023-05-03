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
                if message.text.starts(with: "https://firebasestorage.googleapis.com:443/v0/b/terpexchange-ab6a8.appspot.com") {
                    AsyncImage(url: URL(string: message.text)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                } else{
                    Text(message.text)
                        .padding()
                        .background(message.fromID == userID ? Color("CoralPink"): Color.gray)
                        .cornerRadius(30)
                }
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
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.system(size: 25))
                })
                .frame(width: 25, height: 25)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: 20)
                
                let startIndex = messageID.index(messageID.startIndex, offsetBy: 28)
                let endIndex = messageID.index(messageID.startIndex, offsetBy: 55)
                let sellerID = String(messageID[startIndex...endIndex])
                
                if let currItem = itemsDB.fetchItem(userid: sellerID, itemid: String(messageID.suffix(36))) {
                    TitleRow(name: name, imageUrl: URL(string: pfp)!, itemImage: URL(string: itemImage)!, item: Item(id: currItem.id, userID: sellerID, image: currItem.image, title: currItem.title, description: currItem.description, price: currItem.price))
                        .background(Color("CoralPink"))
                        .offset(y: -10)
                        .padding(.bottom, -10)
                }
//                let currItem = itemsDB.fetchItem(userid: sellerID, itemid: String(messageID.suffix(36)))
//                TitleRow(name: name, imageUrl: URL(string: pfp)!, itemImage: URL(string: itemImage)!, item: Item(id: currItem?.id, userID: currItem?.userID, image: currItem?.image, title: currItem?.title, description: currItem?.description, price: currItem?.price))
//                    .background(Color("CoralPink"))
//                    .offset(y: -10)
//                    .padding(.bottom, -10)
                
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
                Button {
                    selectPhoto = true
                } label: {
                    Image(systemName: "photo.fill")
                        .foregroundColor(Color("CoralPink"))
                }
                .font(.system(size: 26))
                .padding(.leading, 10)
                
                TextField("Type something", text: $messageText)
                    .padding()
                    .onSubmit {
                        submitMessage()
                    }
                Button {
                    submitMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color("CoralPink"))
                }
                .font(.system(size: 26))
                .padding(.trailing, 10)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .background(Color.white)
            .padding(.vertical, -35)
        }
        .sheet(isPresented: $selectPhoto) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage, selectedImages: $selectedImages)
                .onDisappear{
                    if selectedImage != UIImage() {
                        showImageAlert = true
                    }
                }
        }
        .alert(isPresented: $showImageAlert) {
            Alert(title: Text("Send Image"),
                  message: Text("Are you sure you want to send the image?"),
                  primaryButton: .default(Text("OK"), action: {
                    let path = "chats/" + messageID
                    let resizedImage = selectedImage.aspectFittedToHeight(200)
                    
                    photoManager.upload(path: path, image: resizedImage) { imageURL in
                        if let imageURL = imageURL {
                            messagesManager.sendMessage(messageID: messageID, text: imageURL)
                        } else {
                            print ("error getting imageURL")
                        }
                    }
                  }),
                  secondaryButton: .default(Text("Cancel"))
            )
        }
    }
    
    func submitMessage(){
        if messageText.count > 0 {
            messagesManager.sendMessage(messageID: messageID, text: messageText)
            messageText = ""
        }
    }
}
