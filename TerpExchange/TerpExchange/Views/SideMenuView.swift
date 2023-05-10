////
//  SideMenuView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 4/13/23.
//

import SwiftUI

struct SubMenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageName: String
    let destination: AnyView
}

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageName: String
//    let handler: () -> Void = {
//        //pass in actual fields
//        print("Tapped Item")
//    }
    
    let destination: AnyView
    let subMenuItems: [SubMenuItem]?
    
    @State var isExpanded = false // add a state property to keep track of the menu state
}

struct MenuContent: View {
    
    init() {
        // Makes the Scroll View white
        UIScrollView.appearance().indicatorStyle = .white
    }
    
    let items: [MenuItem] = [
        MenuItem(text: "General", imageName: "gear", destination: AnyView(ContentView()), subMenuItems: nil),
        
        MenuItem(text: "Tickets", imageName: "ticket", destination: AnyView(ContentView()), subMenuItems: [
            SubMenuItem(text: "Concerts", imageName: "pencil", destination: AnyView(ContentView())),
            SubMenuItem(text: "Sports", imageName: "power", destination: AnyView(ContentView()))
        ]),
        
        MenuItem(text: "Clothing & Shoes", imageName: "tshirt", destination: AnyView(ContentView()), subMenuItems: [
            SubMenuItem(text: "Women's Clothing", imageName: "pencil", destination: AnyView(ContentView())),
            SubMenuItem(text: "Men's Clothing", imageName: "power", destination: AnyView(ContentView()))
        ]),
        
        MenuItem(text: "Electronics & Media", imageName: "tv.and.mediabox", destination: AnyView(ContentView()), subMenuItems: [
            SubMenuItem(text: "Video Games & Consoles", imageName: "gamecontroller", destination: AnyView(ContentView())),
            SubMenuItem(text: "Audio & Speakers", imageName: "power", destination: AnyView(ContentView()))
        ]),
        
        MenuItem(text: "Games & Toys", imageName: "puzzlepiece", destination: AnyView(ContentView()), subMenuItems: [
            SubMenuItem(text: "Toys", imageName: "pencil", destination: AnyView(ContentView())),
            SubMenuItem(text: "Games & Puzzles", imageName: "power", destination: AnyView(ContentView()))
        ]),
        
        MenuItem(text: "Subleasing", imageName: "house", destination: AnyView(ContentView()), subMenuItems: [
            SubMenuItem(text: "Residential Apartments", imageName: "pencil", destination: AnyView(ContentView())),
            SubMenuItem(text: "Equipment", imageName: "power", destination: AnyView(ContentView()))
        ]),
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)).opacity(0.85)
            
            VStack(alignment: .leading, spacing: 0) {
                
                // Add title for side menu
                Text("ALL CATEGORIES")
                    .foregroundColor(Color.white)
                    .font(.system(size: 25))
                    .bold()
                    .padding()
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(items) { item in
                            
                            if let subItems = item.subMenuItems {
                                // Dropdown menu
                                Menu {
                                    ForEach(subItems) { subItem in
                                        Button(action: {
                                        
                                            // Toggle the menu state
                                            item.isExpanded.toggle()
                                            
                                            // Navigate to sub-item destination
                                            navigateToView(subItem.destination)
                                        }, label: {
                                            Label(subItem.text, systemImage: subItem.imageName)
                                        })
                                    }
                                } label: {
                                    HStack {
                                        // Main item button
                                        Label(item.text, systemImage: item.imageName)
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 20))
                                        
                                        Spacer()
                                        
                                        if item.isExpanded {
                                            Image(systemName: "chevron.down")
                                                    .foregroundColor(Color.white)
                                                    .font(.system(size: 20))
                                        } else {
                                            Image(systemName: "chevron.right")
                                                    .foregroundColor(Color.white)
                                                    .font(.system(size: 20))
                                        }
                                    }
                                }
                                .padding()
                                .foregroundColor(Color.white)
                                
                            } else {
                                // Regular button
                                Button(action: {
                                    
                                    // Navigate to item destination
                                    navigateToView(item.destination)
                                }, label: {
                                    HStack {
                                        Image(systemName: item.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color.white)
                                            .frame(width: 20, height: 20, alignment: .center)
                                        
                                        Text(item.text)
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 20))
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                })
                                .foregroundColor(Color.white)
                            }
                            
                            //Divider()
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.top, 30)
        }
    }
    
    // Function to navigate to a given view
    func navigateToView<Content: View>(_ view: Content) {
        let view = UIHostingController(rootView: view)
        UIApplication.shared.windows.first?.rootViewController = view
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

struct SideMenu: View {
    let sideMenuWidth: CGFloat
    let isMenuOpen: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            // Dimmed Background View
            GeometryReader { _ in
                EmptyView()
            }
            .background(.ultraThinMaterial)
            .opacity(self.isMenuOpen ? 1 : 0)
            .animation(Animation.easeInOut(duration: 0.5))
            .onTapGesture {
                self.toggleMenu()
            }
            
            // Menu Content
            HStack {
                MenuContent()
                    .frame(width: sideMenuWidth)
                    .offset(x: isMenuOpen ? 0 : -sideMenuWidth)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}
