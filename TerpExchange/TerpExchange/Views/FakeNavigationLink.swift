//
//  FakeNavigationLink.swift
//  TerpExchange
//
//  Created by kushal on 4/22/23.
//

import SwiftUI

struct FakeNavigationLink: View {
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let insets = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
        let stackViewHeight = screenSize.height - insets.top - insets.bottom
        
        VStack(spacing: 0) {
            Image("rubix")
                .resizable()
                .scaledToFill()
                .frame(width: screenSize.width, height: stackViewHeight/2 + insets.top)
            
            ZStack{
                Color.red
                    .cornerRadius(30)
                Text("hello")
            }
            .offset(y: -25)
            .padding(.bottom, -25)
            .frame(width: screenSize.width, height: stackViewHeight/2 + insets.top)
        }
        .ignoresSafeArea()
    }
    
}

struct FakeNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        FakeNavigationLink()
    }
}
