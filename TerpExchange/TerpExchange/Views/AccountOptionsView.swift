//
//  AccountOptionsView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

struct AccountOptionsView: View {
    let gold = Color(red: 252.0/255.0, green: 194.0/255.0, blue: 0)
    
    var body: some View {
//        NavigationView {
//            VStack {
//                AccountOptionsPage()
//                    .navigationTitle("")
//            }
//        }
        
        AccountOptionsPage()
            .navigationTitle("")
    }
}

struct AccountOptionsPage: View {
    @StateObject private var firebaseAuth = FirebaseAuthenticationModel()
    let gold = Color(red: 252.0/255.0, green: 194.0/255.0, blue: 0)
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                Text("TerpExchange")
                    .font(.custom("Righteous-Regular", size: 42, relativeTo: .headline))
                    .bold()
                    .foregroundColor(gold)
                    .frame(alignment: .top)
                    .padding(.bottom, 20)
                
                
                Text("SIGN UP / LOG IN")
                    .font(.custom("SourceSansPro-Black", size: 25, relativeTo: .headline))
                    .bold()
                    .foregroundColor(.black)
                    .frame(alignment: .top)
                    .padding(.bottom, 30)
                
                Button {
                    firebaseAuth.signUpWithGoogle()
                } label: {
                    GoogleLoginButton(image: Image("google"), text: Text("Sign in with Google"))
                }
                
                NavigationLink(destination: LogInAccountView(), label: {
                    LogInWithEmailButton(image: Image(systemName: "envelope.fill"), text: Text("Log in with Email"))
                        .padding(.top, 30)
                })
                
                NavigationLink(destination: SignUpAccountView(), label: {
                    SignUpWithEmailButton(image: Image(systemName: "envelope"), text: Text("Sign up with Email"))
                        .padding(.top, 30)
                })
                
//                Button {
//
//                } label: {
//                    LogInWithEmailButton(image: Image(systemName: "envelope.fill"), text: Text("Log in with Email"))
//                        .padding(.top, 30)
//                }
                
                Spacer()
                
            }
            .padding()
        }
    }
}

struct GoogleLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        
        HStack {
            
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
                    .frame(width: 30.0, height: 30.0)
                
                image
                    .resizable()
                    .frame(width: 20.0, height: 20.0)
            }
            
            
            Spacer()
            
            text
                .font(.title2)
                .foregroundColor(Color.white)
                .bold()
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color.blue)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    }
}

struct SignUpWithEmailButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        
        HStack {
            
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
                    .frame(width: 30.0, height: 30.0)
                
                image
                    .resizable()
                    .frame(width: 20.0, height: 15.0)
                    .foregroundColor(Color.black)
            }
            
            
            Spacer()
            
            text
                .font(.title2)
                .foregroundColor(Color.white)
                .bold()
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color.black)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    }
}

struct LogInWithEmailButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        
        HStack {
            
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
                    .frame(width: 30.0, height: 30.0)
                
                image
                    .resizable()
                    .frame(width: 20.0, height: 15.0)
                    .foregroundColor(Color.black)
            }
            
            
            Spacer()
//                .frame(width: 55)
            
            text
                .font(.title2)
                .foregroundColor(Color.white)
                .bold()
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color.red)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    }
}


struct AccountOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountOptionsView()
    }
}
