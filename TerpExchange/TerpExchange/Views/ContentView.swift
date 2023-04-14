//
//  ContentView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .house
    
    var body: some View {
        ZStack {
            switch tabSelected{
            case .house:
                HomeView()
            case .message:
                ChatsView()
            case .camera:
                PostView()
            case .person:
                HomeView()
//                UserProfileView(userId: "test")
            }
            ZStack{
                VStack {
                    Spacer()
                    NavbarView(selectedTab: $tabSelected)
                        .offset(y: -5)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
