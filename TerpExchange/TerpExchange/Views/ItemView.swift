//
//  ItemView.swift
//  TerpExchange
//
//  Created by user235913 on 3/28/23.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var item: Item

    var body: some View {
        NavigationView {
            ScrollView {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Go Back to FirstView")
                })
                VStack (alignment: .leading) {
                    ZStack {
                        TabView {
                            item.image
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
                        Text(String(item.title))
                            .font(.system(size: 24))
                            .fontWeight(.bold)
//                            .fontDesign(.rounded)
                        Text(String(item.price))
                            .foregroundColor(.pink)
                        Text("Sold by " + item.userID)
                        Text("Category: Games\n")
                        Text("Description:")
                        Text(String(item.description))
                        HStack {
//                            NavigationLink("Chat", destination: ChatsView()).padding(5)
//                                .frame(width:100, height:25)
//                                .border(.black)
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

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView()
//    }
//}

