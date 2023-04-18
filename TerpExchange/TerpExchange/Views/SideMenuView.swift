////
//  SideMenuView.swift
//  TerpExchange
//
//  Created by kushal on 4/13/23.
//

import SwiftUI

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
        MenuItem(text: "Home", imageName: "house", destination: AnyView(ContentView())),
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
