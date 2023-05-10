//
//  NavbarView.swift
//  TerpExchange
//
//  Created by kushal on 3/23/23.
//

import SwiftUI
enum Tab: String, CaseIterable {
    case house
    case message
    case camera
    case person
}

struct NavbarView: View {
    @Binding var selectedTab: Tab
    @State private var scaleEffect : Tab = .house
    @State var validTabs: [Tab] = [.house, .message, .camera, .person]
    
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
        if (validTabs.contains(selectedTab)) {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack{
                        Image(systemName: selectedTab == tab ? fillImage: tab.rawValue)
                            .scaleEffect(tab == scaleEffect ? 1.30 : 1.0)
                            .foregroundStyle(tab == selectedTab ? redColor.gradient : Color.gray.gradient)
                            .font(.system(size: 20))
                        
                        Text(tabName(tab: tab))
                            .fontWeight(.heavy)
                            .font(.system(size: 14))
                            .offset(y: 3)
                            .foregroundColor(tab == selectedTab ? redColor : .gray)
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
}
