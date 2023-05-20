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
    @State private var chosenItem = Item(id: "Blank", userID: "", image: [], title: "", description: "", price: 0.0, category: "")
    @State private var categoryItems: [Item] = []
    @Binding var filter : String
    
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
                        
                        if filter == "all" {
                            if !isMenuOpen {
                                Text(filterTitle(filter))
                                    .font(.custom("IBMPlexSans-Bold", size: 26, relativeTo: .headline))
                                    .padding(.trailing, 40)
                                    .foregroundColor(redColor)
                            } else {
                                Text(filterTitle(filter))
                                    .font(.custom("IBMPlexSans-Bold", size: 26, relativeTo: .headline))
                                    .padding(.trailing, -2)
                                    .foregroundColor(redColor)
                            }
                        } else {
                            if (filter == "tv.and.mediabox" || filter == "tshirt" ||
                                filter == "paintbrush.pointed" || filter == "figure.mind.and.body" ||
                                filter == "puzzlepiece" || filter == "sportscourt" ||
                                filter == "ticket") {
                                if !isMenuOpen {
                                    Text(filterTitle(filter))
                                        .font(.custom("IBMPlexSans-Bold", size: 26, relativeTo: .headline))
                                        .padding(.trailing, 40)
                                        .foregroundColor(redColor)
                                } else {
                                    Text(filterTitle(filter))
                                        .font(.custom("IBMPlexSans-Bold", size: 26, relativeTo: .headline))
                                        .padding(.trailing, -2)
                                        .foregroundColor(redColor)
                                }
                            }
                        }
                        
                        Spacer()
                        
                    }
                    
                    ScrollView {
                        
//                        Picker(selection: $filter, label: Text("Picker Selection"), content: {
//                            Text("All").tag("all")
//                            Text("Clothing & Shoes").tag("tshirt")
//                            Text("Electronics & Media").tag("tv.and.mediabox")
//                            Text("Games & Toys").tag("gamecontroller")
//                                        })
//                                        .frame(width: 300)
//                                        .pickerStyle(SegmentedPickerStyle())
//                                        .padding()
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
                            if (filter == "all") {
                                ForEach(itemsDB.userItems.sorted(by: {$0.timestamp > $1.timestamp}), id: \.id) {item in
                                    AsyncImage(url: URL(string: item.image[0])) { image in
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
                            else {
                                ForEach(itemsDB.userItems.filter{ $0.category == filter }.sorted(by: {$0.timestamp > $1.timestamp}), id: \.id) {item in
                                    AsyncImage(url: URL(string: item.image[0])) { image in
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
    
    func filterTitle(_ filter: String) -> String {
        switch filter {
        case "tv.and.mediabox":
            return "Electronics"
            
        case "tshirt":
            return "Clothing & Shoes"
            
        case "paintbrush.pointed":
            return "Collectibles & Art"
            
        case "figure.mind.and.body":
            return "Health & Beauty"
            
        case "puzzlepiece":
            return "Games & Toys"
            
        case "sportscourt":
            return "Sports & Outdoors"
            
        case "ticket":
            return "Tickets"
            
        default:
            return "TerpExchange"
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filter: "all")
    }
}
