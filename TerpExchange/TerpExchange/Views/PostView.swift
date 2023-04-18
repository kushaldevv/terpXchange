//
//  PostView.swift
//  TerpExchange
//
//  Created by kushal on 3/23/23.
//
// Leul Mesfin

import SwiftUI

struct PostView: View {
    @State private var selectPhoto = false
    @State private var photoLibrary = false
    @State private var selectedImage = UIImage()
    
    @State var titleField = ""
    @State var categoryField = ""
    @State var descripField = ""
    @State var priceField = ""
    @State var flag = false
    @State var showDetails = false
    
    
    var body: some View {
        VStack {
            Text(photoLibrary ? "library" : "camera")
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                photoLibrary = false
                selectPhoto = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                    
                    Text("Take Photo")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
            
            Button(action: {
                photoLibrary = true
                selectPhoto = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $selectPhoto) {
            ImagePicker(sourceType: photoLibrary ? .photoLibrary : .camera, selectedImage: $selectedImage)
        }
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
