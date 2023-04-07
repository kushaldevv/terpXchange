//
//  ContentView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            // Post item footer
            HStack {
                // Back button
                Image(systemName: "arrowshape.backward.fill")
                    .foregroundColor(Color.red)
                    .font(.system(size: 30, weight: .bold))
                
                // Post title
                Text("Post an Item")
                    .bold()
                    .font(.system(size: 40))
                    .padding()
                    
                // Cancel post
                Image(systemName: "x.circle.fill")
                    .foregroundColor(Color.red)
                    .font(.system(size: 25, weight: .bold))
            }
            .offset(y: -160)
            
            
            HStack {
                // Take Photo
                Capsule()
                    .fill(.gray)
                    .frame(width: 300, height: 50)
                    .overlay(Text("Take Photo").bold())
                    .offset(y:-150)
            }
            
            HStack {
                // Select Photo
                Capsule()
                    .fill(.gray)
                    .frame(width: 300, height: 50)
                    .overlay(Text("Select Photo").bold())
                    .offset(y:-130)
            }
            
            HStack {
                // Title
                Text("Title")
                    .offset(x: 150, y: -120)
                    .bold()
                
                Capsule()
                    .fill(.gray)
                    .frame(width: 300, height: 50)
                    .offset(x: -20, y:-80)
                
            }
            // Title text blurb
            Text("For example: Nike Air Max, swimming cap, etc")
                .offset(y:-75)
                .font(.system(size: 14))
            
            HStack {
                // Category
                Text("Category")
                    .offset(x: 145, y: -80)
                    .bold()
                
                Capsule()
                    .fill(.gray)
                    .frame(width: 300, height: 50)
                    .offset(x: -40, y:-40)
            }
            
            HStack {
                // Description
                Text("Description")
                    .offset(x: 90, y: -30)
                    .bold()
                
                Text("This is description box")
                    .border(.black)
                    .offset(x: -45)
            }
            
            HStack {
                // Price
                Text("Price")
                    .bold()
                    .offset(x: 70, y: 15)
                
                Text("Price placeholder")
                    .border(.black)
                    .offset(x: -37, y: 40)
            }
            
            HStack {
                // Post button
                Capsule()
                    .fill(.gray)
                    .frame(width: 120, height: 50)
                    .offset(y:80)
                    .overlay(Text("Post")
                        .bold()
                        .offset(y:80))
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
