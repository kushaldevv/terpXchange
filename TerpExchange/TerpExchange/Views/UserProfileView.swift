//
//  UserProfileView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/15/23.
//

import SwiftUI


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
    @Binding var rating: Double
    let size: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName:"person.crop.circle.fill")
                .resizable()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .foregroundColor(.red)
            
            VStack {
                HStack {
                    Text("dasaaaaaa")
                    Spacer()
                }
                
                HStack {
                    ForEach(1..<6) { index in
                        Image(systemName: starImageName(for: rating, index: index))
                            .foregroundColor(.yellow)
                            .font(.system(size: 20))
                            .padding(.trailing, -5)
                            .onTapGesture {
                                self.rating = Double(index)
                            }
                    }
//                    Text("(69)")
                    Spacer()
                }
                .padding(.top, -7)
            }
        }
        
    }
}

struct UserProfileView: View {
    @State private var rating = 2.0
    var body: some View {
        VStack {
            Text("Account")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .font(.system(size: 34, weight: .bold))
            
            
            HStack {
                UserRatingView(rating: $rating, size: 70)
                
                Text("(69)")
                    .offset(x: -70, y: 12)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, -17)
            .padding(.leading, 50)
//            HStack {
//            Image(systemName:"person.crop.circle.fill")
//                .resizable()
//                .frame(width: 70, height: 70)
//                .clipShape(Circle())
//                .foregroundColor(.red)
//
//                VStack {
//                    HStack {
//                        Text("dasaaaaaa")
//                        Spacer()
//                    }
//
//                    HStack {
//                        ForEach(1..<6) { index in
//                            Image(systemName: starImageName(for: rating, index: index))
//                                .foregroundColor(.yellow)
//                                .font(.system(size: 20))
//                                .padding(.trailing, -5)
//                                .onTapGesture {
//                                    self.rating = Double(index)
//                                }
//                        }
//                        Text("(69)")
//                        Spacer()
//                    }
//                    .padding(.top, -7)
//                }
//            }
            
            Spacer().frame(height: 50)
            
            Text("Reputation")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .font(.system(size: 23, weight: .bold))
            
            UserRatingView(rating: $rating, size: 50)
                .padding(.top, -0)
                .padding(.leading, 40)
            
            Text("+rep, easy going and fast to respond. Wasn't late to meetup")
                .frame(maxWidth: 300)
            HStack {
                Spacer()
                Text("See all reviews")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.top, 10)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Spacer().frame(height: 50)
            
            HStack {
                Text("Items from this seller")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .font(.system(size: 23, weight: .bold))
            }
            
//            NavigationView {
//                NavigationLink(destination: HomeView()) {
//                    Text("Go to another page")
//                        .font(.headline)
//                        .foregroundColor(.blue)
//                }
//            }
            
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
            }
        }
        Spacer()
    }
}


    

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
