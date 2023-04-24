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
    var itemImage = Image("rubix")
    
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
                    .font(.system(size: 25))
                    .bold()

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            itemImage
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Rectangle())
                .cornerRadius(10)
        }
        .padding(.horizontal, 15)
    }
}

//struct TitleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleRow()
//    }
//}
