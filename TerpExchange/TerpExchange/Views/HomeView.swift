//
//  HomeView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/17/23.
//

import SwiftUI

var cards = [card](repeating: card(), count: 24)
let cardsCount = cards.count

struct card: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(coralPinkColor)
            .frame(width: 120, height: 120)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 8, x: -5, y: -5)
    }
}


struct HomeView: View {
    @State private var searchText: String = ""

    var body: some View {
            VStack{
                HStack{
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 22, height: 18)
                        .padding(.leading, 20)
                        .accentColor(coralPinkColor)
                    Spacer()
                    Text("TerpExchange")
                        .padding(.trailing, 140)
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundColor(coralPinkColor)
                }
                
                ScrollView {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading, 10)
                        TextField("Search item", text: $searchText)
                            .foregroundColor(.black)
                    }
                        .padding(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(width: screenWidth - 50, height: 40)
                        )
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(),spacing: 0),
                        GridItem(.flexible(),spacing: 0),
                        GridItem(.flexible(),spacing: 0)
                    ], spacing: 7) {
                        ForEach(0..<cardsCount) { i in
                            cards[i]
                        }
                    }
//                        VStack {
//                            ForEach (0..<5) { i in
//                                HStack{
//                                    ForEach (0..<3) { j in
//                                        cards[0]
//                                    }
//                                }
//                            }
//                        }
                }
                    .padding(5)
            }
            
            .background(offwhiteColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()

    }
}
