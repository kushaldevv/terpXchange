//
//  ItemView.swift
//  TerpExchange
//
//  Created by user235913 on 3/28/23.
//

import SwiftUI


//struct userReviewBox: View {
//
//    @StateObject var reviewDB: ReviewsDB = ReviewsDB(useridd: "knNQ1y1S2PTDc0BUg9YkkE9c8072")
//    @State var item: Item
//
//    var body: some View{
//        VStack {
//
//            if(!reviewDB.reviews.isEmpty) {
//                ZStack() {
//                    Rectangle()
//                        .foregroundColor(
//                            Color(red: 253.0/255.0, green: 138.0/255.0, blue: 138.0/255.0)
//                                .opacity(0.22))
//                        .frame(width: UIScreen.main.bounds.width - 20, height: 140)
//                        .cornerRadius(20)
//                    VStack{
//                        HStack {
//
//                            UserRatingView2(rating: Double((reviewDB.reviews[0].rating)), size: 50, displayName: reviewDB.reviews[0].reviewerName, userProfileURL: reviewDB.reviews[0].reviewerPhotoURL)
//                                .padding(.bottom, 200)
//
//                        }
//                        .padding(.leading, 20)
//                        .padding(.bottom, -190)
//                        .padding(.top, 0)
//
//
//                        Text(reviewDB.reviews[0].details)
//                            .frame(maxWidth: 288, alignment: .leading)
//                            .lineLimit(1)
//                            .truncationMode(.tail)
//                            .offset(x: 10, y: -7)
//                            NavigationLink(destination: ReviewsView(currUserId: item.userID)) {
//                                Text("See all reviews ➤")
//                                    .font(.system(size: 23, weight: .bold))
//                                    .foregroundColor(.blue)
//                                    .padding(.leading, 40)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                        }
//                    }
//                }
//            } else {
//                ZStack() {
//                    Rectangle()
//                        .foregroundColor(
//                            Color(red: 253.0/255.0, green: 138.0/255.0, blue: 138.0/255.0)
//                                .opacity(0.22))
//                        .frame(width: UIScreen.main.bounds.width - 20, height: 60)
//                        .cornerRadius(20)
//                    VStack{
//
//                        if(reviewDB.reviews.isEmpty) {
//
//                            NavigationLink(destination: ReviewsView(currUserId: item.userID)) {
//                                Text("User has no Reviews ➤")
//                                    .font(.system(size: 23))
//                                    .foregroundColor(.blue)
//                                    .padding(.leading, 40)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .onAppear {
//                reviewDB.fetchReviews(userid: item.userID)
//        }
//    }
//
//}

struct ItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var item: Item
    @State private var showSecondView = false
    @State private var showUserProfileView = false
    @State private var messageID = ""
    @State private var sellerName = ""
    @State private var sellerPFP = ""
    @State private var sellingItem = ""
    @State private var animateButton = false
    @State private var showDetails = false
    @StateObject var reviewDB: ReviewsDB = ReviewsDB(useridd: "knNQ1y1S2PTDc0BUg9YkkE9c8072")
    
    
    let textColor = Color.black
    var body: some View {
        let stackViewHeight = screenHeight - insets.top - insets.bottom
        NavigationView{
            ZStack{
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(.black)
                    }
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .clipShape(Circle())
                    .padding(.leading)
                    .position(x: 40, y: 70)
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: item.category)
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(.black)
                            .offset(x: -40)
                    }
                    .frame(width: 136, height: 50)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.leading)
                    .position(x: 190, y: 70)
                }
                .zIndex(2)
                VStack(spacing: 0){
                    TabView {
                        ForEach(item.image, id : \.self) { i in
                            AsyncImage(url: URL(string: i)) { image in
                                image.resizable().scaledToFill().ignoresSafeArea()
                                    .padding(.top, -25)
                                
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(width: screenSize.width + 1, height: stackViewHeight/2 + insets.top)
                    
                    ZStack(alignment: .top){
                        RadialGradient(gradient: Gradient(colors: [.white, .gray]), center: .center, startRadius: 1, endRadius: 1000)
                            .cornerRadius(40)
                        ScrollViewReader{ proxy in
                            ScrollView{
                                VStack(spacing: 0){
                                    Text(String(item.title))
                                        .font(.system(size: 28, design: .monospaced))
                                        .fontWeight(.black)
                                        .kerning(3)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .foregroundStyle(textColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 15)
                                        .padding(.top, 20)
                                        .id("title")
                                    
                                    VStack(alignment: .leading, spacing: 10){
                                        Divider()
                                            .frame(width: screenWidth).padding(.horizontal, -15).opacity(0)
                                        
                                        Text(formatPrice(item.price))
                                            .font(.system(size: 28))
                                            .fontWeight(.heavy)
                                            .foregroundStyle(textColor)
                                            .padding(.bottom, 10)
                                        
                                        NavigationLink(destination: UserProfileView(userName: sellerName, userId: item.userID, userProfileURL: URL(string: sellerPFP))){
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
               
                                        Text("Posted on: " + displayDate(date: item.timestamp))
                                            .font(.system(size: 15))
                                            .fontWeight(.medium)
                                    }
                                    ZStack {
                                        Circle()
                                            .fill(userID != item.userID ? Color.black.opacity(0.92).gradient : Color.red.opacity(0.9).gradient)
                                            .shadow(color: .gray, radius: 25, x: 15, y: 20)
                                            .frame(height: 100)
                                        if (userID != item.userID){
                                            Circle().fill(Color.green.gradient).frame(height:100).scaleEffect(self.animateButton ? 1 : 0.001)
                                        }
                                        Text(userID != item.userID ? "CHAT" : "Your\nItem")
                                            .font(.system(size: 14))
                                            .fontWeight(.heavy)
                                            .foregroundColor(.white)
                                            .kerning(4)
                                            .padding(25)
                                    }
                                    .animation(.linear(duration: 0.6))
                                    .onLongPressGesture(minimumDuration: 0.6, pressing: { isPressed in
                                        self.animateButton.toggle()
                                    }, perform: {
                                        if (userID != item.userID){
                                            createChat(itemImage: item.image[0], sellerID: item.userID, sellerName: sellerName, sellerPFP: sellerPFP, messageID: messageID)
                                            showSecondView = true
                                            Text(messageID + sellerName + sellerPFP + sellingItem)
                                                .frame(width: 0, height: 0)
                                        }
                                    })
                                    .padding(.top, 20)
                                    Button(!showDetails ? "  DETAILS ▼" : "ITEM INFO ▲"){
                                        
                                        showDetails.toggle()
                                        
                                    }
                                    .foregroundColor(Color.black)
                                    .fontWeight(.heavy)
                                    .kerning(3)
                                    .padding(.top, 25)
                                    VStack {
                                        Text(item.description)
                                            .id("details")
                                            .frame(width: screenWidth - 50, height: (stackViewHeight/2 + insets.top) - 10)
                                            .offset(y: -30)
                                        
                                        //                                    userReviewBox(reviewDB: reviewDB, item: item)
                                        //                                        .offset(y: -180)
                                    }
                                    
                                    
                                }
                                .padding(.horizontal, 15)
                                .onChange(of: showDetails) { newValue in
                                    if newValue {
                                        withAnimation {
                                            proxy.scrollTo("details", anchor: .top)
                                        }
                                    }else{
                                        withAnimation {
                                            proxy.scrollTo("title", anchor: .top)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .offset(y: -18)
                    .padding(.bottom, -25)
                    .frame(width: screenWidth + 20, height: stackViewHeight/2 + insets.top)
                    
                }
                .ignoresSafeArea()
                .onAppear{
                    getUserProfile(id: item.userID) { profile in
                        messageID = userID + item.userID + item.id
                        sellerName = profile["name"]!
                        sellerPFP = profile["pfp"]!
                        sellingItem = item.image[0]
                    }
                }
                .sheet(isPresented: $showUserProfileView){
                    UserProfileView(userName: sellerName, userId: item.userID)
                }
                .fullScreenCover(isPresented: $showSecondView, content: {
                    ChatView(messageID: $messageID,
                             name: $sellerName,
                             pfp: $sellerPFP, itemImage: $sellingItem)
                })
            }
        }
        .navigationTitle("")
        .edgesIgnoringSafeArea(.top)
    }
    
    func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        let item = Item(id: "EAE329DA-EB83-49C5-8A16-BC8ED2D3021B", userID: userID, image: ["https://firebasestorage.googleapis.com:443/v0/b/terpexchange-ab6a8.appspot.com/o/users%2FknNQ1y1S2PTDc0BUg9YkkE9c8072%2F458C0A5A-D0A9-4B06-BBA2-7B25B5F1D052?alt=media&token=8d570daa-88d9-4c86-9428-3226af9b1fbc","https://firebasestorage.googleapis.com:443/v0/b/terpexchange-ab6a8.appspot.com/o/users%2FknNQ1y1S2PTDc0BUg9YkkE9c8072%2F458C0A5A-D0A9-4B06-BBA2-7B25B5F1D052?alt=media&token=8d570daa-88d9-4c86-9428-3226af9b1fbc"], title: "Airpods Second Generation", description: "LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLor", price: 15.0, category: "electronics")
//        return ItemView(item: .constant(item))
//    }
//}
