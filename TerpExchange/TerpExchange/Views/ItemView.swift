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
    @State var animateButton = false
    
    let textColor = Color.black
    
    
    var body: some View {
        let stackViewHeight = screenHeight - insets.top - insets.bottom
        
        //        ScrollView{
        VStack(spacing: 0){
            TabView {
                AsyncImage(url: URL(string: item.image[0])) { image in
                    image.resizable().scaledToFill()                .ignoresSafeArea()
                    
                } placeholder: {
                    ProgressView()
                }
                Color.blue
                    .ignoresSafeArea()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(width: screenSize.width + 1, height: stackViewHeight/2 + insets.top)
            
            ZStack{
                RadialGradient(gradient: Gradient(colors: [.white, .black]), center: .center, startRadius: 1, endRadius: 1500)
                    .cornerRadius(40)
                
                VStack{
                    Text(String(item.title))
                        .font(.system(size: 24, design: .monospaced))
                        .fontWeight(.black)
                        .kerning(3)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .foregroundStyle(textColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.leading, 15)
                        .border(Color.black)
                    
                    VStack(alignment: .leading, spacing: 10){
                        Divider()
                            .frame(width: screenWidth).padding(.horizontal, -15).opacity(0)
                        
                        Text(formatPrice(item.price))
                            .font(.system(size: 28))
                            .fontWeight(.heavy)
                            .foregroundStyle(textColor)
                            .padding(.bottom, 10)
                        
                        Text("Posted on: " + displayDate(date: item.timestamp))
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                        
                        HStack{
                            AsyncImage(url: URL(string: sellerPFP)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(50)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 40, height: 40)
                            }
                            Text(sellerName)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 15))
                                .lineLimit(1)
                                .bold()
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 15)
            }
            .offset(y: -18)
            .padding(.bottom, -25)
            .frame(width: screenWidth + 20, height: stackViewHeight/2 + insets.top)
            
        }
        .ignoresSafeArea()
        //        }
        .onAppear{
            getUserProfile(id: item.userID) { profile in
                messageID = userID + item.userID + item.id
                sellerName = profile["name"]!
                sellerPFP = profile["pfp"]!
                sellingItem = item.image[0]
            }
        }
        .fullScreenCover(isPresented: $showSecondView, content: {
            ChatView(messageID: $messageID,
                     name: $sellerName,
                     pfp: $sellerPFP, itemImage: $sellingItem)
        })
    }
    
    func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Item(id: "EAE329DA-EB83-49C5-8A16-BC8ED2D3021B", userID: "knNQ1y1S2PTDc0BUg9YkkE9c8072", image: ["https://firebasestorage.googleapis.com:443/v0/b/terpexchange-ab6a8.appspot.com/o/users%2FknNQ1y1S2PTDc0BUg9YkkE9c8072%2F458C0A5A-D0A9-4B06-BBA2-7B25B5F1D052?alt=media&token=8d570daa-88d9-4c86-9428-3226af9b1fbc"], title: "Airpods pro", description: "LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLor", price: 15.0)
        return ItemView(item: .constant(item))
    }
}
