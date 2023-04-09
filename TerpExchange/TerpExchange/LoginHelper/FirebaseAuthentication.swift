//
//  FirebaseAuthentication.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/14/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import GoogleSignIn

class FirebaseAuthenticationModel: ObservableObject {
    
    @Published var isLogin: Bool = false
    @Published var showAlert: Bool = false
    
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
            
            let terpmailEmailAddress = "[A-Za-z0-9._%+-]+@terpmail\\.umd\\.edu$"
            
            let terpmailEmailAddressPredicate = NSPredicate(format: "SELF MATCHES %@", terpmailEmailAddress)
            
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
                
//                if !terpmailEmailAddressPredicate.evaluate(with: user.email) {
//                    try? Auth.auth().signOut()
//
//                    self.showAlert = true
//
//                    user.delete { error in
//                      if let error = error {
//                          print(error.localizedDescription)
//                      } else {
//                        // Accounts that do not end with a "@termail.umd.edu" email address will be deleted.
//                      }
//                    }
//
//                    return
//                }
                
                // Store user ID in Firestore
//                let db = Firestore.firestore()
//                let usersRef = db.collection("users").document(user.uid)
//
//
//                usersRef.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        // User already exists, do nothing
//                        print("User already exists")
//                    } else {
//                        // User does not exist, create new document
//                        let data: [String: Any] = [
//                            "userId": user.uid,
//                            "displayName": user.displayName ?? "",
//                            "email": user.email ?? "",
//                            "photoURL": user.photoURL?.absoluteString ?? "",
//                            "reviews": []
//                        ]
//
//                        usersRef.setData(data) { error in
//                            if let error = error {
//                                print("Error saving user ID to database: \(error.localizedDescription)")
//                            } else {
//                                print("User ID saved to database")
//                            }
//                        }
//                    }
//                }
                
                
                print(user)

                UserDefaults.standard.set(true, forKey: "signIn")
            }
        }
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }


}

