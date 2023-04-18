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
//let coralPinkColor = Color("CoralPink")
let offwhiteColor = Color("offwhite")

enum Tab: String, CaseIterable {
    case house
    case message
    case camera
    case person
}

struct NavbarView: View {
    @Binding var selectedTab: Tab
    @State private var scaleEffect : Tab = .house
    
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    func tabName(tab: Tab) -> String {
        switch tab {
        case .house:
            return "Home"
        case .message:
            return "Inbox"
        case .camera:
            return "Post"
        case .person:
            return "Account"
        }
    }
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Spacer()
                VStack{
                    Image(systemName: selectedTab == tab ? fillImage: tab.rawValue)
                        .scaleEffect(tab == scaleEffect ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? Color.red : .gray)
                        .font(.system(size: 20))
                    
                    Text(tabName(tab: tab))
                        .fontWeight(.heavy)
                        .font(.system(size: 14))
                        .offset(y: 3)
                        .foregroundColor(tab == selectedTab ? Color.red : .gray)
                }
                .onTapGesture {
                    selectedTab = tab
                    withAnimation(.easeInOut(duration: 0.1)) {
                        scaleEffect = tab
                    }
                }
                Spacer()
            }
        }
        .frame(width: nil, height: 60)
        .background(.thinMaterial)
        .cornerRadius(20)
        .padding(9)
        
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView(selectedTab: .constant(.house))
    }
}
