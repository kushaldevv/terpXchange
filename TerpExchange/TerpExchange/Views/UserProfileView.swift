//
//  UserProfileView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/15/23.
//

import SwiftUI
import FirebaseAuth

func starImageName(for rating: Double, index: Int) -> String {
    let ratingInt = Int(rating.rounded())
    let ratingFraction = rating - Double(ratingInt)
    if index <= ratingInt {
        return "star.fill"
    } else if index == ratingInt + 1 && ratingFraction > 0 {
        return "star.leadinghalf.fill"
    } else {
        return "star"
    }
}



struct UserRatingView: View {
    @State private var profileImage: UIImage?
    @Binding var rating: Double
    let size: CGFloat
    let displayName: String // temp is id atm
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


//struct UserRatingView: View {
//    @State private var profileImage: UIImage?
////    @State private var profileURLString: String?
//    @Binding var rating: Double
//    let size: CGFloat
//    let displayName: String // temp is id atm
//    let userProfileURL: URL?
//
//    @State private var otherUser = OtherUsersDB()
//
//
//    var body: some View {
//        HStack {
//            Image(systemName:"person.crop.circle.fill")
//                .resizable()
//                .frame(width: size, height: size)
//                .clipShape(Circle())
//                .foregroundColor(.red)
//
//            VStack {
//                HStack {
//                    Text(displayName)
//                    Spacer()
//                    if let urlString = userProfileURL?.absoluteString {
//                        Text(urlString)
//                    }
//                }
//
//                HStack {
//                    ForEach(1..<6) { index in
//                        Image(systemName: starImageName(for: rating, index: index))
//                            .foregroundColor(.yellow)
//                            .font(.system(size: 20))
//                            .padding(.trailing, -5)
//                            .onTapGesture {
//                                self.rating = Double(index)
//                            }
//                    }
////                    Text("(69)")
//                    Spacer()
//                }
//                .padding(.top, -7)
//            }
//        }
//
//    }
//
//}



struct UserProfileView: View {
    @State private var rating = 2.0
    @StateObject private var firebaseAuth = FirebaseAuthenticationModel()
    @StateObject private var otherUser = OtherUsersDB()
    
    var userId: String
    var userProfileURL: URL?
    
    var body: some View {
        VStack {

            Text("Account")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .font(.system(size: 34, weight: .bold))
            
            
            HStack {
//                UserRatingView(rating: $rating, size: 70, displayName: firebaseAuth.getCurrentUser()?.displayName ?? "Unknown")
                UserRatingView(rating: $rating, size: 70, displayName: userId, userProfileURL: userProfileURL)
                
                Text("(69)")
                    .offset(x: -70, y: 12)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, -17)
            .padding(.leading, 50)
            
            Spacer().frame(height: 50)
            
            Text("Reputation")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .font(.system(size: 23, weight: .bold))
            
            // feature: SHOULD BE FROM REVIEWS, NOT CURRENT USER
            UserRatingView(rating: $rating, size: 70, displayName: Auth.auth().currentUser?.displayName ?? "Unknown", userProfileURL: Auth.auth().currentUser?.photoURL)
//            UserRatingView(rating: $rating, size: 70, displayName: Auth.auth().currentUser?.displayName ?? "Unknown")

                .padding(.top, -0)
                .padding(.leading, 40)
            
            Text("+rep, easy going and fast to respond. Wasn't late to meetup")
                .frame(maxWidth: 300)
            
            NavigationView {
                HStack(spacing: 0) {
//                Spacer()
                    NavigationLink(destination: ReviewsView()) {
                        Text("See all reviews")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.blue)
                            .padding(.leading, 40)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
            }
                .padding(.top, -85)
            }
            
//            NavigationView {
//                HStack(spacing: 0) {
//                    NavigationLink(destination: TestViewUsers()) {
//                        Text("Test Another Account")
//                            .font(.system(size: 23, weight: .bold))
//                            .foregroundColor(.blue)
//                            .padding(.leading, 4)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//
//            }
//                .padding(.top, -5)
//            }
            
            HStack {
                Text("Items from this seller")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, -105)
                    .font(.system(size: 23, weight: .bold))
            }
            
            VStack{
                NavigationView {
                    ScrollView {
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(),spacing: 0),
                            GridItem(.flexible(),spacing: 0),
                            GridItem(.flexible(),spacing: 0)
                        ], spacing: 7) {
                            ForEach(0..<cardsCount, id: \.self) { i in ZStack {
                                cards[i]
                                NavigationLink( destination: ItemView())
                                {
                                    Image("TerpExchangeLogo-transparent")
                                        .resizable()
                                        .frame(width: 160, height: 100)
                                }
                            }
                            }
                        }
                    }
                    .padding(5)
                }
                
                .background(offwhiteColor)
            }.padding(.top, -80)
        }
        Spacer()
    }
}


    

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userId: "test")
    }
}
