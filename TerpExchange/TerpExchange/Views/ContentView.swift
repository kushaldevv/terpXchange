//
//  ContentView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct ContentView: View {
    @State private var tabSelected: Tab = .house

    var body: some View {
        ZStack {
            switch tabSelected{
            case .house:
                HomeView()
            case .message:
                ChatView()
            case .camera:
                PostView()
            case .person:
                UserProfileView(userName: "userName ContentView", userId: userID)
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
