//
//  ContentView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .house
    @State var filter: String

    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hue: 0.99, saturation: 0.6, brightness: 1.7), Color(hue: 0.93, saturation: 0.29, brightness: 1.1)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                switch tabSelected{
                case .house:
                    HomeView(filter: $filter)
                case .message:
                    ChatsView()
                case .camera:
                    PostView()
                case .person:
                    UserProfileView(userName: username, userId: userID, userProfileURL: userPhotoURL)}
                ZStack{
                    VStack {
                        Spacer()
                        NavbarView(selectedTab: $tabSelected)
                            .offset(y: -18)
                    }
                    .ignoresSafeArea()
                    
                }
            }
        }
        .navigationTitle("")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(filter: "all")
//    }
//}
