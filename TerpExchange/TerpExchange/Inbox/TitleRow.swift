//
//  TitleRow.swift
//  TerpExchange
//
//  Created by kushal on 4/17/23.
//

import SwiftUI

struct TitleRow: View {
    var name : String
    var imageUrl : URL
    var itemImage : URL
    var item: Item
    
    
    @State private var showSecondView = false
    @State private var chosenItem = Item(id: "Blank", userID: "", image: [], title: "", description: "", price: 0.0)

    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size:18))
                    .bold()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            AsyncImage(url: itemImage) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .onTapGesture{
                chosenItem = item
                showSecondView = true
            }
        }
        .padding(.horizontal, 15)
        .fullScreenCover(isPresented: $showSecondView, content: {
                ItemView(item: $chosenItem)
        })
    }
}

//struct TitleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleRow()
//    }
//}
