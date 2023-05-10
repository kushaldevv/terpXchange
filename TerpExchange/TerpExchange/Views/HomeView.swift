//
//  HomeView.swift
//  TerpExchange
//
//  Created by kushal on 3/17/23.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var isMenuOpen = false
    @State var str = "click"
    @StateObject var itemsDB = UserItemsDB()
    
    @State private var showSecondView = false
    @State private var chosenItem = Item(id: "Blank", userID: "", image: [], title: "", description: "", price: 0.0)
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        if !isMenuOpen {
                            Button(action: {
                                self.isMenuOpen.toggle()
                            }, label: {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 22, height: 18)
                                    .padding(.leading, 20)
                                    .accentColor(redColor)
                            })
                        }
                        
                        Spacer()
                        
                        if !isMenuOpen{
                            Text("TerpExchange")
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
                                .fontDesign(.rounded)
                                .padding(.trailing, 40)
                                .foregroundColor(redColor)
                        } else {
                            Text("TerpExchange")
                                .font(.system(size: 22))
                                .fontWeight(.heavy)
                                .fontDesign(.rounded)
                                .padding(.trailing, -2)
                                .foregroundColor(redColor)
                        }
                        
                        Spacer()

                    }

                    ScrollView {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .padding(.leading, 10)
//                            TextField("Search item", text: $searchText)
//                                .foregroundColor(.black)
//                        }
//                        .padding(20)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.gray, lineWidth: 1)
//                                .frame(width: screenWidth - 50, height: 40)
//                        )
                        Divider()
                            .padding(.bottom, 20)
                        

                        LazyVGrid(columns: [
                            GridItem(.flexible(),spacing: 0),
                            GridItem(.flexible(),spacing: 0),
                            GridItem(.flexible(),spacing: 0)
                        ], spacing: 7) {
                            
                            ForEach(itemsDB.userItems.sorted(by: {$0.timestamp > $1.timestamp}), id: \.id) {item in
                                ForEach(item.image, id: \.self) {imageURL in
                                    AsyncImage(url: URL(string: imageURL)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .cornerRadius(10)
                                    .frame(width: screenWidth/3.25, height: screenWidth/3.25)
                                    .onTapGesture {
                                        chosenItem = item
                                        showSecondView = true
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding(5)
                }
            }
            .onAppear() {
                itemsDB.fetchItems()
            }
            .fullScreenCover(isPresented: $showSecondView, content: {
                ItemView(item: $chosenItem)
            })
        }
        
        SideMenu(sideMenuWidth: screenWidth/1.4, isMenuOpen: isMenuOpen, toggleMenu: toggleMenu)
            .edgesIgnoringSafeArea(.all)
            .zIndex(isMenuOpen ? 1 : 0)
    }
    
    func toggleMenu() {
        isMenuOpen.toggle()
    }
}

