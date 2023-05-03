//
//  ItemView.swift
//  TerpExchange
//
//  Created by user235913 on 3/28/23.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var item: Item
    @State private var showSecondView = false
    @State private var messageID = ""
    @State private var sellerName = ""
    @State private var sellerPFP = ""
    @State private var sellingItem = ""
     
    
    var body: some View {
        ScrollView {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Go Back to FirstView")
            })
            VStack (alignment: .leading) {
                ZStack {
                    TabView {
                        AsyncImage(url: URL(string: item.image[0])) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        Image("google")
                            .resizable()
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding([.leading, .trailing])
                    .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.width)
                    .ignoresSafeArea()
                    
                    
                }
                Group {
                    Text(String(item.title))
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    //                            .fontDesign(.rounded)
                    Text(String(item.price))
                        .foregroundColor(.pink)
                    Text("Sold by " + item.userID)
                    Text("Category: Games\n")
                    Text("Description:")
                    Text(String(item.description))
                    if userID != item.userID {
                        HStack {
                            Button {
                                getUserProfile(id: item.userID) { profile in
                                    messageID = userID + item.userID + item.id
                                    sellerName = profile["name"]!
                                    sellerPFP = profile["pfp"]!
                                    sellingItem = item.image[0]
                                    createChat(itemImage: item.image[0], sellerID: item.userID, sellerName: sellerName, sellerPFP: sellerPFP, messageID: messageID)
                                    Text(messageID + sellerName + sellerPFP + sellingItem)
                                        .frame(width: 0, height: 0)
                                    showSecondView = true
                                }
                            } label: {
                                Text("Chat")
                                    .padding(5)
                                    .frame(width:100, height:25)
                            }
                            .border(.black)
                            Button {
                            } label: {
                                Text("Purchase")
                                    .padding(5)
                                    .frame(width:100, height:25)
                            }
                            .border(.black)
                        }.padding([.leading], 75)
                    }
                }
                .padding([.leading, .trailing])
                Text(messageID + sellerName + sellerPFP + sellingItem)
                    .frame(width: 0, height: 0)
            }
        }
        .sheet(isPresented: $showSecondView, content: {
            ChatView(messageID: $messageID,
                     name: $sellerName,
                     pfp: $sellerPFP, itemImage: $sellingItem)
        })
    }
}

//struct ItemView_Previews: PreviewProvider {
//    @State private var chosenItem = Item(id: "Blank", userID: "", image: [], title: "", description: "", price: 0.0)
//
//    static var previews: some View {
//        ItemView(item: Item())
//    }
//}





