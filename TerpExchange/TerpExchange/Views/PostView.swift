//  PostView.swift
//  TerpExchange
//
//  Created by kushal on 3/23/23.
//
// Leul Mesfin
// once we click cancel or back, when u go back to the post page
// it should revert to its original UI, not the home (FIX this)
import SwiftUI

struct PostView: View {
    @State private var selectPhoto = false
    @State private var camera = false
    @State private var selectedImage = UIImage()
    @State private var selectedImages = [UIImage]()
    @State var titleField = ""
    @State var categoryField = ""
    @State var descripField = ""
    @State var priceField = ""
    @State var flag = false
    @State var showDetails = false
    @State var idx = 0
    @ObservedObject var itemsDB = UserItemsDB()
    @StateObject var photoManager = PhotoManager()
    
    var body: some View {
        NavigationView {
            //ScrollView {
            VStack (alignment: .leading) {
                Text("Post an Item") // Post Item title
                    .bold()
                    .font(.largeTitle)
                    .padding()
                    .position(x: 200, y: 20)
                
                ZStack {
                    TabView {
                        ForEach(selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 270, height: 270)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 5))
                                .shadow(radius: 15)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding([.leading, .trailing])
                    .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.width)
                }
                //.position(x: 195, y: 20)
                
                VStack { // VStack for take and select buttons
                    Button(action: { // Take photo
                        camera = true
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
                    .frame(width: 300, height: 50)
                    .bold()
                    .position(x: 170, y: -200)
                    
                    
                    Button(action: { // Select Photo Button
                        camera = false
                        selectPhoto = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                            
                            Text("Select from Library")
                                .font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    .frame(width: 300, height: 50)
                    .bold()
                    .position(x: 170, y: -200)
                } // vstack for take and select photos
                .position(x: 220, y: -175)
                
                VStack(alignment: .leading) {
                    Text("Title")
                        .position(x: 30, y: -60)
                    
                    // Title Text Field
                    TextField("Title", text: $titleField)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                        .frame(width: 340)
                        .textFieldStyle(.roundedBorder)
                    //.position(x: 180, y: 10)
                        .position(x: 180, y: -40)
                    
                    // Description
                    Text("Description")
                        .position(x: 60, y: -25)
                    
                    // Description text field
                    TextEditor(text: $descripField)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 370, height: 100)
                        .position(x: 180, y: 20)
                    
                    
                    
                    // Price
                    Text("Price")
                        .position(x: 35, y: 70)
                    
                    // Price text field
                    TextField("Price", text: $priceField)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                        .keyboardType(.numberPad) // only numbers
                        .frame(width: 340)
                        .textFieldStyle(.roundedBorder)
                        .position(x: 185, y: 85)
                    
                    // Post button
                    
                    Button {
                        //itemsDB.addItem(price: Double(self.priceField) ?? 0.0, description: self.descripField, title: self.titleField)
                        var imagesURLs : [String] = []
                        let path = "users/" + userID
                        
                        //ForEach(selectedImages, id: \.self) { image in
                            
                            let resizedImage = selectedImages[0].aspectFittedToHeight(200)
                            photoManager.upload(path: path, image: resizedImage) { imageURL in
                                if let imageURL = imageURL {
                                    imagesURLs.append(imageURL)
                                    itemsDB.addItem(price: Double(self.priceField) ?? 0.0, description: self.descripField, title: self.titleField, images: imagesURLs)
                                } else {
                                    print ("error getting imageURL")
                                }
                            }
                        //}
                        }
                label:
                    {
                        Text("Post")
                    }
                    
                } // VStack for user input
                .position(x: 200, y: -40)
                
            }
            .sheet(isPresented: $selectPhoto) {
                ImagePicker(sourceType: camera ? .camera : .photoLibrary, selectedImage: $selectedImage, selectedImages: $selectedImages)
            }
        }
        //}
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

