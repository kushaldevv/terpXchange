//
//  FakeNavigationLink.swift
//  TerpExchange
//
//  Created by kushal on 4/22/23.
//

import SwiftUI

struct FakeNavigationLink: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Go Back to FirstView")
        })
    }
}

struct FakeNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        FakeNavigationLink()
    }
}
