//
//  AccountOptionsView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import SwiftUI

struct AccountOptionsView: View {
    let gold = Color(red: 252.0/255.0, green: 194.0/255.0, blue: 0)
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("TerpExchange")
                        .font(.custom("Righteous-Regular", size: 40, relativeTo: .headline))
                        .bold()
                        .foregroundColor(gold)
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                HStack {
                    
                }
            }
        }
    }
}

struct AccountOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountOptionsView()
    }
}
