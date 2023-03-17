//
//  HomeView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/17/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                AccountView()
                    .navigationTitle("")
            }
        }
    }
}

struct AccountView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationLink(destination: AccountOptionsView(), label: {
                    Text("Hello, World!")
                })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
