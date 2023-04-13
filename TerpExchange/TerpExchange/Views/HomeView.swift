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

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageName: String
//    let handler: () -> Void = {
//        //pass in actual fields
//        print("Tapped Item")
//    }
    
    let destination: AnyView
}

struct MenuContent: View {
    let items: [MenuItem] = [
        MenuItem(text: "Home", imageName: "house", destination: AnyView(HomeView())),
        MenuItem(text: "Settings", imageName: "house", destination: AnyView(PostView())),
        MenuItem(text: "Profile", imageName: "house", destination: AnyView(HomeView())),
        MenuItem(text: "Activity", imageName: "house", destination: AnyView(HomeView())),
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1))
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    
                    Button(action: {
                        // Navigate to destination when button is tapped
                        navigateToView(item.destination)
                    }, label: {
                        
                        HStack {
                            Image(systemName: item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 32, height: 32, alignment: .center)
                            
                            Text(item.text)
                                .foregroundColor(Color.white)
                                .bold()
                                .font(.system(size: 22))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .padding()
                    })
                    
                    //Divider()
                }
                
                Spacer()
            }
            .padding(.top, 25)
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
            .background(Color.red.opacity(0.15))
            .opacity(self.isMenuOpen ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
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

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var isMenuOpen = false

    var body: some View {
           
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
                                .accentColor(coralPinkColor)
                        })
                    }
                    
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
                        ForEach(0..<cardsCount, id: \.self) { i in
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
            
            
            SideMenu(sideMenuWidth: UIScreen.main.bounds.width/1.5, isMenuOpen: isMenuOpen, toggleMenu: toggleMenu)
                .edgesIgnoringSafeArea(.all)
            
        }
//        .padding(.top, 40)
//        .edgesIgnoringSafeArea(.all)
    }
    
    func toggleMenu() {
        isMenuOpen.toggle()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
