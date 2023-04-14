//
//  HomeView.swift
//  TerpExchange
//
//  Created by kushal on 3/17/23.
//

import SwiftUI

struct basicCardView: View{
    var item: Item
    
    var body: some View {
        item.image
            .resizable()
            .frame(width: 120, height: 120)
            .cornerRadius(8)
    }
}

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var isMenuOpen = false
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    HStack {
                        
                        if !isMenuOpen {
                            Button(action: {
                                // Open Side Menu
                                self.isMenuOpen.toggle()
                            }, label: {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 22, height: 18)
                                    .padding(.leading, 20)
                                    .accentColor(Color.red)
                            })
                        }
                        
                        Spacer()
                        
                        Text("TerpExchange")
                            .padding(.trailing, 140)
                            .fontWeight(.heavy)
                            .fontDesign(.rounded)
                            .foregroundColor(Color.red)
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
                            ForEach(0..<items.count, id: \.self) { i in ZStack {
                                NavigationLink( destination: ItemView())
                                {
                                    basicCardView(item: items[i])
                                }
                            }
                            }
                            
                        }
                    }
                    .padding(5)
                }
                .background(offwhiteColor)
                
                SideMenu(sideMenuWidth: UIScreen.main.bounds.width/1.5, isMenuOpen: isMenuOpen, toggleMenu: toggleMenu)
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
    }
    
    func toggleMenu() {
        isMenuOpen.toggle()
    }
}
