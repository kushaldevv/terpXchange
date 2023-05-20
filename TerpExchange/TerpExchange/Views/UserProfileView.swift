//
//  ProfileTest.swift
//  TerpExchange
//
//  Created by David Do on 5/8/23.
//

import SwiftUI
import FirebaseAuth

func starImageName2(for rating: Double, index: Int) -> String {
    let ratingInt = Int(rating)
    let ratingFraction = rating - Double(ratingInt)
    if index < ratingInt {
        return "star.fill"
    } else if index == ratingInt && ratingFraction >= 0.5 {
        return "star.leadinghalf.fill"
    } else {
        return "star"
    }
}

struct blob: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.173*width, y: -0.309*height))
        path.addCurve(to: CGPoint(x: 0.331*width, y: -0.1855*height), control1: CGPoint(x: 0.232*width, y: -0.2655*height), control2: CGPoint(x: 0.293*width, y: -0.235*height))
        path.addCurve(to: CGPoint(x: 0.3645*width, y: -0.0125*height), control1: CGPoint(x: 0.3695*width, y: -0.136*height), control2: CGPoint(x: 0.3855*width, y: -0.068*height))
        path.addCurve(to: CGPoint(x: 0.24*width, y: 0.1265*height), control1: CGPoint(x: 0.343*width, y: 0.0435*height), control2: CGPoint(x: 0.284*width, y: 0.087*height))
        path.addCurve(to: CGPoint(x: 0.129*width, y: 0.25*height), control1: CGPoint(x: 0.196*width, y: 0.166*height), control2: CGPoint(x: 0.1665*width, y: 0.2015*height))
        path.addCurve(to: CGPoint(x: -0.018*width, y: 0.3895*height), control1: CGPoint(x: 0.0915*width, y: 0.298*height), control2: CGPoint(x: 0.0455*width, y: 0.3585*height))
        path.addCurve(to: CGPoint(x: -0.2*width, y: 0.3735*height), control1: CGPoint(x: -0.0815*width, y: 0.4205*height), control2: CGPoint(x: -0.163*width, y: 0.422*height))
        path.addCurve(to: CGPoint(x: -0.247*width, y: 0.1555*height), control1: CGPoint(x: -0.2365*width, y: 0.325*height), control2: CGPoint(x: -0.2285*width, y: 0.226*height))
        path.addCurve(to: CGPoint(x: -0.3155*width, y: -0.0035*height), control1: CGPoint(x: -0.2655*width, y: 0.085*height), control2: CGPoint(x: -0.31*width, y: 0.0425*height))
        path.addCurve(to: CGPoint(x: -0.268*width, y: -0.166*height), control1: CGPoint(x: -0.321*width, y: -0.049*height), control2: CGPoint(x: -0.288*width, y: -0.098*height))
        path.addCurve(to: CGPoint(x: -0.1995*width, y: -0.3735*height), control1: CGPoint(x: -0.248*width, y: -0.234*height), control2: CGPoint(x: -0.242*width, y: -0.3205*height))
        path.addCurve(to: CGPoint(x: -0.0105*width, y: -0.4275*height), control1: CGPoint(x: -0.157*width, y: -0.427*height), control2: CGPoint(x: -0.0785*width, y: -0.446*height))
        path.addCurve(to: CGPoint(x: 0.173*width, y: -0.309*height), control1: CGPoint(x: 0.057*width, y: -0.409*height), control2: CGPoint(x: 0.114*width, y: -0.3525*height))
        path.closeSubpath()
        return path
    }
}

struct UserRatingView2: View {
    @State private var profileImage: UIImage?
    var rating: Double
    let size: CGFloat
    let displayName: String // now is name atm
    let userProfileURL: URL?
    
    var body: some View {
        Group {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                Image(systemName:"person.crop.circle.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .foregroundColor(.red)
            }
            
            VStack {
                HStack {
                    Text(displayName)
                    Spacer()
                }
                
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: starImageName2(for: rating, index: index))
                            .foregroundColor(Color(red: 255/255, green: 180/255, blue: 0/255))
                            .font(.system(size: 20))
                            .padding(.trailing, -5)
                    }
                    Spacer()
                }
                .padding(.top, -10)
            }
            
        }
        .onAppear {
            guard let url = userProfileURL else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                DispatchQueue.main.async {
                    profileImage = UIImage(data: data)
                }
            }.resume()
        }
    }
}

struct complements: View {
    
    var body: some View {
        Image("complement1")
            .resizable()
            .frame(width: 42, height: 23)
            .offset(x: 100, y: -30)
        
        Image("complement1")
            .resizable()
            .frame(width: 42, height: 23)
            .offset(x: 95, y: 50)
            .scaleEffect(x: -1, y: 1)
        
        Image("complement2")
            .resizable()
            .frame(width: 80, height: 63)
            .offset(x: 38, y: -78)
            .rotationEffect(Angle.degrees(5))
        
        Image("complement3")
            .resizable()
            .frame(width: 70, height: 50)
            .offset(x: -50, y: -72)
        
        blob()
            .foregroundColor(Color(red: 237.0/255.0, green: 191.0/255.0, blue: 252.0/255.0, opacity: 1.0))
            .frame(width: 60, height: 40)
            .offset(x: -65, y: 6)
        
        blob()
            .foregroundColor(Color(red: 237.0/255.0, green: 191.0/255.0, blue: 252.0/255.0, opacity: 1.0))
            .frame(width: 50, height: 30)
            .offset(x: -70, y: 60)
            .rotationEffect(Angle.degrees(220))
        
        Image("complement5")
            .resizable()
            .frame(width: 25, height: 25)
            .offset(x: -10, y: -80)
        
        Image("complement5")
            .resizable()
            .frame(width: 25, height: 25)
            .offset(x: -30, y: 80)
        
        Image("complement5")
            .resizable()
            .frame(width: 20, height: 20)
            .offset(x: 50, y: 50)
        
        Image("complement6")
            .resizable()
            .frame(width: 50, height: 45)
            .offset(x: 20, y: 86)
    }
}

struct complements2: View {
    
    var body: some View {
       
        Image("complement6")
            .resizable()
            .frame(width: 50, height: 45)
            .offset(x: -25, y: -105)
        
        Image("complement7")
            .resizable()
            .frame(width: 200, height: 100)
            .offset(x: 60, y: -105)
            .rotationEffect(Angle.degrees(-20))
        
        Image("complement7")
            .resizable()
            .frame(width: 200, height: 100)
            .offset(x: 45, y: 105)
            .rotationEffect(Angle.degrees(-20))
        
        Image("complement7")
            .resizable()
            .frame(width: 200, height: 100)
            .offset(x: -60, y: -105)
            .rotationEffect(Angle.degrees(-20))
        
    }
}

struct UserRatingViewMain: View {
    @State private var profileImage: UIImage?
    var rating: Double
    let size: CGFloat
    let displayName: String // now is name atm
    let userProfileURL: URL?
    let numReviews: Int
    
    var body: some View {
        VStack() {
            
//            Group {
            Spacer().frame(height: 16)
                ZStack {
                    
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                    } else {
                        Image(systemName:"person.crop.circle.fill")
                            .resizable()
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                            .foregroundColor(.red)
                    }
                    
                    complements()
                    complements2()
                }
            

                Spacer().frame(height: 60)
                
                HStack(alignment: .center) {
                    Text(displayName)
                        .font(.custom("SourceSansPro-Black", size: 26, relativeTo: .headline))
                        .kerning(3)

                }
                
                
                HStack() {
                    ForEach(0..<5) { index in
                        Image(systemName: starImageName2(for: rating, index: index))
                            .foregroundColor(.yellow)
                            .font(.system(size: 30))
                            .padding(.trailing, -5)
                    }
                    Text("(\(numReviews))")
                        .font(.system(size: 22))
                }
                .padding(.top, -7)
//            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            guard let url = userProfileURL else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                DispatchQueue.main.async {
                    profileImage = UIImage(data: data)
                }
            }.resume()
        }
    }
}


struct UserProfileView: View {
    
    @StateObject private var firebaseAuth = FirebaseAuthenticationModel()
    @StateObject private var otherUser = OtherUsersDB()
    @StateObject var itemsDB = UserItemsDB()
    @State private var showSecondView = false
    @StateObject var reviewDB: ReviewsDB = ReviewsDB(useridd: "user")
    @State private var chosenItem = Item(id: "Blank", userID: "", image: [], title: "", description: "", price: 0.0, category: "")
    @State private var tabSelected: Tab = .person
    @State private var isAnimating = false
    @State private var isPressed = false
    @State private var displayLogoutAlert = false
    @State private var loggingOutOfAccount = false

    
    var userName: String
    var userId: String
    var userProfileURL: URL?
    
    var body: some View {
            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Color(hue: 0.99, saturation: 0.6, brightness: 1.7), Color(hue: 0.93, saturation: 0.29, brightness: 1.1)]), startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
                ScrollView{
                VStack {
                    HStack {
                        
                        Text("Account")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .font(.system(size: 34, weight: .bold))
                        
                        if(userId == userID) {
                            Button(action: {
                                displayLogoutAlert.toggle()
                            }, label: {
                                Text("Logout")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 90, height: 40)
                                    .background(Color.red)
                                    .cornerRadius(20)
                                    .offset(x: -15)
                            })
                            .disabled(loggingOutOfAccount)
                            .alert(isPresented: $displayLogoutAlert) {
                                Alert(title: Text("Log out?"), message: Text("Are you sure you want to log out?"), primaryButton: .destructive(Text("Log out")) {
                                    loggingOutOfAccount = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        firebaseAuth.signOutGoogleAccount()
                                    }
                                }, secondaryButton: .cancel())
                            }
                        }
                    }
                    
                    Spacer().frame(height: 70)
                    
                    HStack(alignment: .center) {
                        UserRatingViewMain(rating: (reviewDB.averageRating(userId: userID)), size: 110, displayName: userName, userProfileURL: userProfileURL, numReviews: (reviewDB.numberOfReviews(userId: userId)))
                    }
                    
                    Spacer().frame(height: 10)
                    Text("Reputation")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom, -2)
                        .font(.system(size: 23, weight: .bold))
                    
                    
                    
                    
                    if(!reviewDB.reviews.isEmpty) {
                        ZStack() {
                            Rectangle()
                                .foregroundColor(
                                    Color(red: 253.0/255.0, green: 138.0/255.0, blue: 138.0/255.0)
                                        .opacity(0.22))
                                .frame(width: UIScreen.main.bounds.width - 20, height: 140)
                                .cornerRadius(20)
                            VStack{
                                HStack {
                                    if(reviewDB.reviews.isEmpty) {
                                        
                                    } else {
                                        UserRatingView2(rating: Double((reviewDB.reviews[0].rating)), size: 50, displayName: reviewDB.reviews[0].reviewerName, userProfileURL: reviewDB.reviews[0].reviewerPhotoURL)
                                            .padding(.bottom, 200)
                                    }
                                }
                                .padding(.leading, 20)
                                .padding(.bottom, -190)
                                .padding(.top, 0)
                                
                                
                                Text(reviewDB.reviews[0].details)
                                    .frame(maxWidth: 288, alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .offset(x: 10, y: -7)
                                
                                NavigationLink(destination: ReviewsView(currUserId: userId)) {
                                    Text("See all reviews ➤")
                                        .font(.system(size: 23, weight: .bold))
                                        .foregroundColor(.blue)
                                        .padding(.leading, 40)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    //                            NavigationLink(destination: ReviewsView(currUserId: userId)) {
                                    //                                Text("See all reviews")
                                    //                                    .font(.system(size: 23, weight: .bold))
                                    //                                    .foregroundColor(.blue)
                                    //                                    .padding(.leading, 40)
                                    //                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    //                            }
                                }
                            }
                        }
                    } else {
                        ZStack() {
                            Rectangle()
                                .foregroundColor(
                                    Color(red: 253.0/255.0, green: 138.0/255.0, blue: 138.0/255.0)
                                        .opacity(0.22))
                                .frame(width: UIScreen.main.bounds.width - 20, height: 60)
                                .cornerRadius(20)
                            VStack{
                                
                                if(reviewDB.reviews.isEmpty) {
                                    
                                    NavigationLink(destination: ReviewsView(currUserId: userId)) {
                                        Text("User has no Reviews ➤")
                                            .font(.system(size: 23))
                                            .foregroundColor(.blue)
                                            .padding(.leading, 40)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                        }
                    }
                    HStack {
                        Text("Items from this seller")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                            .padding(.top, 2)
                            .font(.system(size: 23, weight: .bold))
                    }
                    
                    VStack{
                        ScrollView {
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible(),spacing: 0),
                                GridItem(.flexible(),spacing: 0),
                                GridItem(.flexible(),spacing: 0)
                            ], spacing: 7) {
                                ForEach(itemsDB.specificItems.sorted(by: {$0.timestamp > $1.timestamp}), id: \.id) {item in
                                    ForEach(item.image, id: \.self) {imageURL in
                                        AsyncImage(url: URL(string: imageURL)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .cornerRadius(10)
                                        .frame(width: 118, height: 118)
                                        .onTapGesture {
                                            chosenItem = item
                                            showSecondView = true
                                            print(chosenItem.id)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        .padding(5)
                        
                    }
                }
                .onAppear() {
                    reviewDB.fetchReviews(userid: userId)
                    itemsDB.fetchSpecificUserItems(userid: userId)
                    
                }
                .fullScreenCover(isPresented: $showSecondView, content: {
                    ItemView(item: $chosenItem)
                })
                .fullScreenCover(isPresented: $loggingOutOfAccount, content: {
                    ProgressView("Logging out...")
                        .frame(maxWidth: screenWidth, maxHeight: screenHeight)
                        .background(.ultraThinMaterial)
                        .scaleEffect(1.5)
                })
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userName: "name placeholder", userId: "id placeholder")
    }
}
