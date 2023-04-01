//
//  ItemView.swift
//  TerpExchange
//
//  Created by user235913 on 3/28/23.
//

import SwiftUI

struct ItemView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    ZStack {
                        TabView {
                            Image("google")
                                .resizable()
                            Image("google")
                                .resizable()
                            
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding([.leading, .trailing])
                        .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.width)
                        
                        
                    }
                    Group {
                        Text("Rubix Cube")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                        Text("$30")
                            .foregroundColor(.pink)
                        Text("Sold by John Smith")
                        Text("Category: Games\n")
                        Text("Description:")
                        Text("Selling a Rubix Cube. It comes with some mini wine glasses and a mni wine bottle.")
                        HStack {
                                NavigationLink("Chat", destination: ChatView()).padding(5)
                                        .frame(width:100, height:25)
                            .border(.black)
                            Button {
                                
                            } label: {
                                Text("Purchase")
                                    .padding(5)
                                    .frame(width:100, height:25)
                            }
                            .border(.black)
                        }.padding([.leading], 75)
                        
                    }
                    .padding([.leading, .trailing])
                }
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
