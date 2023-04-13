//
//  HomeView.swift
//  TerpExchange
//
//  Created by kushal on 3/17/23.
//

import SwiftUI

var cards = [card](repeating: card(), count: 25)
let cardsCount = cards.count

struct card: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 130, height: 130)
            .background(.thinMaterial)
            .overlay(
                Image("TerpExchangeLogo-transparent")
                    .resizable()
                    .frame(width: 160, height: 100)
            )
    }
}


struct HomeView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    HStack{
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 22, height: 18)
                            .offset(x: 20)
                        
                        Text("TerpExchange")
                            .kerning(-1)
                            .font(.system(size: 25))
                            .fontWeight(.black)
//                            .fontDesign(.rounded)
                            .foregroundColor(Color.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .offset(x: -20)
                    }
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
                        ForEach(0..<cardsCount, id: \.self) { i in ZStack {
                            NavigationLink( destination: ItemView())
                            {
                                cards[i]
                            }
                        }
                        }
                    }
                }
                .padding(5)
            }
        }
    }
}
