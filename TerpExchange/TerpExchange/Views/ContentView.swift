//
//  ContentView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var navBarHidden: Bool = false
    
    func hideNavbar () {
        navBarHidden = true
    }
    
    func showNavbar() {
        navBarHidden = false
    }
}

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
                UserProfileView(userId: userID)
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
