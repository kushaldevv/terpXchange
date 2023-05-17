//
//  FakeNavigationLink.swift
//  TerpExchange
//
//  Created by kushal on 4/22/23.
//

import SwiftUI

struct FakeNavigationLink: View {
    @State private var buttonText = "Click me"
    
    var body: some View {
        VStack {
            Button(action: {
                async {
                    buttonText = "Loading..."
                    await Task.sleep(2_000_000_000) // Wait for 2 seconds
                    buttonText = "Clicked!"
                }
            }) {
                Text(buttonText)
                    .padding()
            }
        }
    }
}

struct FakeNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        FakeNavigationLink()
    }
}
