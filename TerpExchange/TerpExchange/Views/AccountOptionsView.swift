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
    @StateObject private var firebaseAuth = FirebaseAuthenticationModel()
    @State private var displayTermsOfService = false
    @State private var displayPrivatePolicy = false
    
    let gold = Color(red: 252.0/255.0, green: 194.0/255.0, blue: 0)
    
    let redColor = Color(red: 253.0/255.0, green: 138.0/255.0, blue: 138.0/255.0)
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("TerpExchange")
                    .font(.custom("Righteous-Regular", size: 42, relativeTo: .headline))
                    .bold()
                    .foregroundColor(redColor)
                
                Image("TerpExchangeLogo-transparent") // "logo" is the name of the image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .offset(y: -30)
                
                Text("Hey! Welcome")
                    .font(.custom("SourceSansPro-Black", size: 30, relativeTo: .headline))
                    .bold()
                    .foregroundColor(Color.black)
                    .offset(y: -40)
                
                Text("Marketplace that provides a convenient way to buy and sell products on campus.")
                    .font(.custom("SourceSansPro-Black", size: 18, relativeTo: .headline))
                    .foregroundColor(Color.gray)
                    .offset(y: 0)
                    .multilineTextAlignment(.center)
                    .opacity(0.6)
                    
//                Text("SIGN UP / LOG IN")
//                    .font(.custom("SourceSansPro-Black", size: 25, relativeTo: .headline))
//                    .bold()
//                    .foregroundColor(Color.black)
//                    .offset(y: 20)
                
                Button {
                    firebaseAuth.signInGoogleAccount()
                } label: {
                    GoogleLoginButton(image: Image("google"), text: Text("Continue with Google"))
                }
                .offset(y: 40)
                
                VStack {
                    
                    Spacer ()
                    
                    HStack {
                        Text("Terms of Service")
                            .font(.custom("SourceSansPro-Black", size: 16, relativeTo: .headline))
                            .bold()
                            .foregroundColor(Color("AccentColorRed"))
                            .onTapGesture {
                                self.displayTermsOfService = true
                            }
                            .offset(x: -40, y: 10)
                        
                        Text("Private Policy")
                            .font(.custom("SourceSansPro-Black", size: 16, relativeTo: .headline))
                            .bold()
                            .foregroundColor(Color("AccentColorRed"))
                            .onTapGesture {
                                self.displayPrivatePolicy = true
                            }
                            .offset(x: 40, y: 10)
                    }
                }
                .fullScreenCover(isPresented: $displayTermsOfService) {
                    TermsOfService()
                }
                
                .fullScreenCover(isPresented: $displayPrivatePolicy) {
                    PrivatePolicy()
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $firebaseAuth.showAlert) {
                Alert(title: Text("INVALID EMAIL ADDRESS"), message: Text("Please sign using a\n'@terpmail.umd.edu' email address"))
            }
        }
    }
}

struct TermsOfService: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("Terms of Service")
                    .bold()
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(Color.black)
                        
                })
            }
            .padding(.bottom, 10)
            .padding(.horizontal)
            .background(Color("AccentColorRed"))
                    
            VStack {
                ScrollView {
                    Text("Here are the terms of service")
                    Spacer()
                }
            }
            
            .padding()
        }
        .background(Color.white)
    }
}

struct PrivatePolicy: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("Private Policy")
                    .bold()
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(Color.black)
                        
                })
            }
            .padding(.bottom, 10)
            .padding(.horizontal)
            .background(Color("AccentColorRed"))
                    
            VStack {
                ScrollView {
                    Text("Here are the private policy terms")
                    Spacer()
                }
            }
            
            .padding()
        }
        .background(Color.white)
    }
}

struct GoogleLoginButton: View {
    var image: Image
    var text: Text
    
    let redColor = Color(red: 253.0/255.0, green: 138.0/255.0, blue: 138.0/255.0)
    
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
        .background(redColor.gradient)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    }
}

struct AccountOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountOptionsView()
    }
}


