//
//  UserProfileView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/15/23.
//

import SwiftUI
import FirebaseAuth

func starImageName(for rating: Double, index: Int) -> String {
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

struct UserRatingView: View {
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
                        Image(systemName: starImageName(for: rating, index: index))
                            .foregroundColor(.yellow)
                            .font(.system(size: 20))
                            .padding(.trailing, -5)
//                            .onTapGesture {
//                                self.rating = Double(index)
//                            }
                    }
//                    Text("(69)")
                    Spacer()
                }
                .padding(.top, -7)
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

struct UserProfileView: View {

    @StateObject private var firebaseAuth = FirebaseAuthenticationModel()
    @StateObject private var otherUser = OtherUsersDB()
    @ObservedObject var reviewDB = ReviewsDB()
    
    var userName: String
    var userId: String
    var userProfileURL: URL?
    
    var body: some View {

        VStack {
            
            Text("Account")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .font(.system(size: 34, weight: .bold))
            
            HStack {
                
                UserRatingView(rating: (reviewDB.averageRating(userId: userID)), size: 70, displayName: userName, userProfileURL: userProfileURL)

                Text("(\(reviewDB.numberOfReviews(userId: userId)))")
                    .offset(x: -70, y: 12)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, -17)
            .padding(.leading, 50)
            
            Spacer().frame(height: 40)
            
            Text("Reputation")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .font(.system(size: 23, weight: .bold))
            
            HStack {
                // feature: SHOULD BE FROM REVIEWS, NOT CURRENT USER
                if(reviewDB.reviews.isEmpty) {
//                    Text("empty")
//                    UserRatingView(rating: (reviewDB.averageRating(userId: userID)), size: 70, displayName: userName, userProfileURL: userProfileURL)
                } else {
//                    Text("nope")
//                    Text("\(reviewDB.reviews[0].reviewerPhotoURL?.absoluteString ?? "No photo URL found")")


                    UserRatingView(rating: Double((reviewDB.reviews[0].rating)), size: 50, displayName: reviewDB.reviews[0].reviewerName, userProfileURL: reviewDB.reviews[0].reviewerPhotoURL)
                        .padding(.bottom, 200)
                }

                
            }
            .padding(.leading, 20)
            .padding(.bottom, -190)
            .padding(.top, 0)
            
            if(reviewDB.reviews.isEmpty) {
//                Text("")
//                    .frame(maxWidth: 300)
                
                NavigationLink(destination: ReviewsView(currUserId: userId, reviewArray: reviewDB.reviews)) {
                    Text("User has no Reviews")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.leading, 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else {
                Text(reviewDB.reviews[0].details)
                    .frame(maxWidth: 300)
                
                NavigationLink(destination: ReviewsView(currUserId: userId, reviewArray: reviewDB.reviews)) {
                    Text("See all reviews")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.leading, 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            HStack {
                Text("Items from this seller")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 15)
                    .font(.system(size: 23, weight: .bold))
            }
            
            VStack{
                ScrollView {

                    LazyVGrid(columns: [
                        GridItem(.flexible(),spacing: 0),
                        GridItem(.flexible(),spacing: 0),
                        GridItem(.flexible(),spacing: 0)
                    ], spacing: 7) {
    //                        ForEach(0..<cardsCount, id: \.self) { i in ZStack {
    //                            cards[i]
    //
    //                            NavigationLink( destination: ItemView())
    //                            {
    //                                Image("TerpExchangeLogo-transparent")
    //                                    .resizable()
    //                                    .frame(width: 160, height: 100)
    //                            }
    //                        }
    //                        }
                    }
                }
                .padding(5)

                .background(offwhiteColor)
            }.padding(.top, 100)
        }
        .onAppear() {
            reviewDB.fetchReviews(userid: userId)

        }
    }
}



struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userName: "name placeholder", userId: "id placeholder")
    }
}
