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
    
    var body: some Scene {
        WindowGroup {
           //AccountOptionsView()
            
            if isSignIn {
                UserProfileAccessPage()
            } else {
                AccountOptionsView()
            }
        }
    }
    
    /* Temporary Back Button for User Profile */
    struct UserProfileAccessPage: View {
        @AppStorage("signIn") var isSignIn = false
        
        var body: some View {
            NavigationStack {
                UserProfileView()
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




