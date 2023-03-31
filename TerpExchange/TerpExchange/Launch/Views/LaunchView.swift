//
//  LaunchView.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/23/23.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "TerpExchange...".map { String($0) }
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    
    @Binding var showLauchView: Bool
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background.ignoresSafeArea()
            
            Image("TerpExchangeLogo-transparent")
                .resizable()
                .frame(width: 160, height: 100)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -5: 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 90)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLauchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLauchView: .constant(true))
    }
}
