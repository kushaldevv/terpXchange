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
    //@AppStorage("signIn") var accountSignedIn = false
    
    @State private var showLaunchView: Bool = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView(filter: "all")
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLauchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}


