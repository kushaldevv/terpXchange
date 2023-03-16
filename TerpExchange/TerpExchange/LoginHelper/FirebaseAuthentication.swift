//
//  FirebaseAuthentication.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/14/23.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

class FirebaseAuthenticationModel: ObservableObject {
    
    @Published var isLogin: Bool = false
    
    func signUpWithGoogle() {
        
        // Retrieve client ID
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Retrieve Configuration
        let config = GIDConfiguration(clientID: clientID)
        
        // Sign in
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: RootUIViewController.rootViewController) { user, error in
            
            if let error = error {
                print(error.localizedDescription)
                
                return
            }
            
            guard
                let user = user?.user,
                let idToken = user.idToken else { return }
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                    return
                }
                
                guard let user = res?.user else { return }
                
                print(user)
                
                UserDefaults.standard.set(true, forKey: "signIn")
            }
        }
    }
}

