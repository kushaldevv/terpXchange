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

    @Published var showAlert: Bool = false
    let placeholder = URL(string: "https://firebasestorage.googleapis.com/v0/b/terpexchange-ab6a8.appspot.com/o/chats%2FuniqueID%2FIMG_2021.png?alt=media&token=f16d80b0-db5d-4738-974b-a2e64610b5ad")
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func updateCurrentUser() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    func updateCurrentUsername() -> String {
        return Auth.auth().currentUser?.displayName ?? ""
    }
    
    func updateCurrentUserPFP() -> URL {
        return Auth.auth().currentUser?.photoURL ?? placeholder!
    }
    
    func signInGoogleAccount() {
        
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
            
            let terpmailEmailAddressRegex = "[A-Za-z0-9._%+-]+@terpmail\\.umd\\.edu$"
            
            let terpmailEmailAddressPredicate = NSPredicate(format: "SELF MATCHES %@", terpmailEmailAddressRegex)
            
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
                let db = Firestore.firestore()
                let usersRef = db.collection("users").document(user.uid)

                usersRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        
                        // User already exists, do nothing
                        print("User Profile Exists in Database")
                    } else {
                        let firestored = FirestoreDB()
                        firestored.saveUserIdToFirestore()
                    }
                }
                
                UserDefaults.standard.set(true, forKey: "signIn")
                
                // Update User Accounts after logging out so accounts are all unique for each user
                userID = self.updateCurrentUser()
                username = self.updateCurrentUsername()
                userPhotoURL = self.updateCurrentUserPFP()
                
                print(userID)
            }
        }
    }
    
    func signOutGoogleAccount() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            UserDefaults.standard.set(false, forKey: "signIn")
        } catch let error as NSError {
            print("Error signing out of account: \(error.localizedDescription)")
        }
    }
}
