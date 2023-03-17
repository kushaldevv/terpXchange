//
//  LogInAccountView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/15/23.
//

import SwiftUI

struct LogInAccountView: View {
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
                
                
                Text("LOG IN")
                    .font(.custom("SourceSansPro-Black", size: 25, relativeTo: .headline))
                    .bold()
                    .foregroundColor(.black)
                    .frame(alignment: .top)
                    .padding(.bottom, 30)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct LogInAccountView_Previews: PreviewProvider {
    static var previews: some View {
        LogInAccountView()
    }
}
