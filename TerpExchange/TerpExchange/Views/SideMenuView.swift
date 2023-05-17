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
    let destination: AnyView
    let subMenuItems: [SubMenuItem]?
}

struct MenuContent: View {
    
    @State var isExpanded = false // add a state property to keep track of the menu state
    @State private var expandedDisclosureGroupId: UUID?
    
    init() {
        // Makes the Scroll View white
        UIScrollView.appearance().indicatorStyle = .white
    }
    
    let items: [MenuItem] = [
        MenuItem(text: "General", imageName: "gear", destination: AnyView(ContentView(filter: "all")), subMenuItems: nil),
        
        MenuItem(text: "Electronics", imageName: "tv.and.mediabox", destination: AnyView(ContentView(filter: "tv.and.mediabox")), subMenuItems: [
            SubMenuItem(text: "View All", imageName: "", destination: AnyView(ContentView(filter: "tv.and.mediabox"))),
//            SubMenuItem(text: "Video Games & Consoles", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Computers & Accessories", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Audio & Speakers", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Cell Phones & Accessories", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Wearables", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "TVs & Media Players", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Printers & Supplies", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Other: Electronics", imageName: "", destination: AnyView(ContentView(filter: "")))
        ]),
        
        MenuItem(text: "Clothing & Shoes", imageName: "tshirt", destination: AnyView(ContentView(filter: "tshirt")), subMenuItems: [
            SubMenuItem(text: "View All", imageName: "", destination: AnyView(ContentView(filter: "tshirt"))),
//            SubMenuItem(text: "Women's Clothing", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Men's Clothing", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Women's Shoes", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Men's Shoes", imageName: "shoeprints.fill", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Other: Clothing & Shoes", imageName: "", destination: AnyView(ContentView(filter: "")))
        ]),
        
        MenuItem(text: "Collectibles & Art", imageName: "paintbrush.pointed", destination: AnyView(ContentView(filter: "paintbrush.pointed")), subMenuItems: [
            SubMenuItem(text: "View All", imageName: "", destination: AnyView(ContentView(filter: "paintbrush.pointed"))),
//            SubMenuItem(text: "Art", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Art & Crafts Supplies", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Antiques", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Collectibles", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Other: Collectibles & Art", imageName: "", destination: AnyView(ContentView(filter: "")))
        ]),
        
        MenuItem(text: "Health & Beauty", imageName: "figure.mind.and.body", destination: AnyView(ContentView(filter: "figure.mind.and.body")), subMenuItems: [
            SubMenuItem(text: "View All", imageName: "", destination: AnyView(ContentView(filter: "figure.mind.and.body"))),
//            SubMenuItem(text: "Personal Care", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Makeup & Cosmetics", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Fragrance", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Tools & Accessories", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Hair care", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Skincare", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Bath & Body", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Other: Health & Beauty", imageName: "", destination: AnyView(ContentView(filter: "")))
        ]),
        
        MenuItem(text: "Games & Toys", imageName: "puzzlepiece", destination: AnyView(ContentView(filter: "puzzlepiece")), subMenuItems: [
            SubMenuItem(text: "View All", imageName: "", destination: AnyView(ContentView(filter: "puzzlepiece"))),
//            SubMenuItem(text: "Board Games & Puzzles", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Toys", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Outdoor Games & Toys", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Card Games", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Stuffed Animals & Plush", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Action Figures & Dolls", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Other: Games & Toys", imageName: "", destination: AnyView(ContentView(filter: "")))
        ]),
        
        MenuItem(text: "Sports & Outdoors", imageName: "football", destination: AnyView(ContentView(filter: "football")), subMenuItems: [
            SubMenuItem(text: "View All", imageName: "", destination: AnyView(ContentView(filter: "sportscourt"))),
//            SubMenuItem(text: "Bikes", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Skateboarding", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Light Electric Vehicles", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Exercise", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Camping & Hiking", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Other: Sports & Outdoors", imageName: "", destination: AnyView(ContentView(filter: ""))),
        ]),
        
        MenuItem(text: "Tickets", imageName: "ticket", destination: AnyView(ContentView(filter: "ticket")), subMenuItems: [
            SubMenuItem(text: "View All", imageName: "", destination: AnyView(ContentView(filter: "ticket"))),
//            SubMenuItem(text: "Concerts", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Sports", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Theater", imageName: "", destination: AnyView(ContentView(filter: ""))),
//            SubMenuItem(text: "Other - Tickets", imageName: "", destination: AnyView(ContentView(filter: "")))
        ]),
    ]
    
    var body: some View {
        ZStack {
            //Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)).opacity(0.85)
//            Color("AccentColorRed")
//                .opacity(0.85)
            RadialGradient(gradient: Gradient(colors: [Color("IndianRed"), Color("AccentColorRed")]), center: .center, startRadius: 1, endRadius: 900)
                .opacity(0.8)
            
            VStack(alignment: .leading, spacing: 0) {
                
                // Add title for side menu
                Text("ALL CATEGORIES")
                    .foregroundColor(Color.white)
                    .font(.custom("IBMPlexSans-Bold", size: 25, relativeTo: .headline))
                    .padding()
                
                Divider()
                    .frame(height: 2)
                    .background(Color.white)
                    .opacity(0.5)
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(items) { item in
                            if let subItems = item.subMenuItems {
                                DisclosureGroup(isExpanded: Binding (
                                    get: { self.expandedDisclosureGroupId == item.id },
                                    set: { newValue in
                                        self.expandedDisclosureGroupId = newValue ? item.id : nil
                                    }), content: {
                                    VStack {
                                        ForEach(subItems) { subItem in
                                            Button(action: {
                                                navigateToView(subItem.destination)
                                            }) {
                                                //Label(subItem.text, systemImage: subItem.imageName)
                                                HStack {
                                                    Text(subItem.text)
                                                        .font(.custom("IBMPlexSans-SemiBold", size: 18, relativeTo: .headline))
                                                        //.font(.system(size: 18))
                                                        //.fontWeight(.medium)
                                                    Label("", systemImage: subItem.imageName)
                                                    
                                                    Spacer()
                                                }
                                                .padding(.top, 20)
                                                .offset(x: 15)
                                            }
                                        }
                                    }
                                }, label: {
                                    HStack {
//                                        Label(item.text, systemImage: item.imageName)
//                                            .foregroundColor(Color.white)
//                                        //.font(.system(size: 20))
//
//                                        Spacer()
                                        
                                        Text(item.text)
                                            .foregroundColor(Color.white)
                                            .font(.custom("IBMPlexSans-Bold", size: 20, relativeTo: .headline))
                                            //.fontWeight(.heavy)
                                        Label("", systemImage: item.imageName)
                                            .foregroundColor(Color.white)
                                    }
                                })
                                .padding()
                                .foregroundColor(Color.white)
                                .accentColor(Color.white)
                            } else {
                                Button(action: {
                                    navigateToView(item.destination)
                                }) {
                                    HStack {
                                        Text(item.text)
                                            .foregroundColor(Color.white)
                                            .font(.custom("IBMPlexSans-Bold", size: 20, relativeTo: .headline))
                                            .multilineTextAlignment(.leading)
                                        
                                        Image(systemName: item.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color.white)
                                            .frame(width: 20, height: 20, alignment: .center)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    //.offset(y: -10)
                                }
                                .foregroundColor(Color.white)
                            }
                        }
                        .padding(.vertical, -2)
                        
                        
                        Spacer()
                    }
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            //.offset(y: 30)
        }
    }
    
    func navigateToView<Content: View>(_ view: Content) {
        let view = UIHostingController(rootView: view)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = view
            window.makeKeyAndVisible()

        }
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
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.toggleMenu()
                }
            }
            
            // Menu Content
            HStack {
                MenuContent()
                    .frame(width: sideMenuWidth)
                    .offset(x: isMenuOpen ? 0 : -sideMenuWidth)
                    .animation(.default, value: isMenuOpen)
                
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filter: "all")
    }
}
