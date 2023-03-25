//
//  NavbarView.swift
//  TerpExchange
//
//  Created by kushal on 3/23/23.
//

import SwiftUI


let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let coralPinkColor = Color("CoralPink")
let offwhiteColor = Color("offwhite")

struct NavbarView: View {
    var body: some View {
        ZStack{
            TabView {
                HomeView()
                    .tabItem(){
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    
                ChatView()
                    .tabItem(){
                        Image(systemName: "message.fill")
                        Text("Inbox")
                    }
                
                PostView()
                    .tabItem(){
                        Image(systemName: "camera.fill")
                        Text("Post")
                    }
                
                AccountOptionsView()
                    .tabItem(){
                        Image(systemName: "person.crop.circle.fill")
                        Text("Account")
                    }
            }
            .accentColor(coralPinkColor)
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
