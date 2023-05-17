//
//  TerpExchangeApp.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct TerpExchangeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("signIn") var accountSignedIn = false
    
    @State private var showLaunchView: Bool = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if accountSignedIn {
                    ContentView(filter: "all")
//                        .colorScheme(.light)
                } else {
                    AccountOptionsView()
//                        .colorScheme(.light)
                }
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLauchView: $showLaunchView)
                            .transition(.move(edge: .leading))
//                            .colorScheme(.light)
                    }
                }
                .zIndex(2.0)
            }
//            .environment(\.colorScheme, .light)
        }
    }
}


