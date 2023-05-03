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
    @AppStorage("signIn") var isSignIn = false
    
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
           //AccountOptionsView()
            
            ZStack {
                if isSignIn {
//                    UserProfileAccessPage()
                    ContentView()
                } else {
//                    NavigationStack{
//                        ContentView()
                    AccountOptionsPage()
//                    }
                    
                }
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
    
    /* Temporary Back Button for User Profile */
    struct UserProfileAccessPage: View {
        @AppStorage("signIn") var isSignIn = false
        
        var body: some View {
            NavigationStack {
                UserProfileView(userId: Auth.auth().currentUser?.displayName ?? "Unknown")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                try? Auth.auth().signOut()
                                GIDSignIn.sharedInstance.signOut()
                                withAnimation(.easeInOut) {
                                    isSignIn = false
                                }
                            
                            }, label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                }
                            })
                        }
                    }
            }
        }
    }
}





