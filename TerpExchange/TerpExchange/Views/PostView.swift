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
    @State private var showImageAlert = false
    @State private var selectedImage = UIImage()
    @State private var selectedImages = [UIImage]()
    
    @State private var titleField = ""
    @State private var descripField = ""
    @State private var priceField = ""
    
    @State private var animateButton = false
    @State private var showAlert = false
    @State private var errorAlert = true
    
    let categoryOptions = ["Electronics", "Clothing & Shoes", "Collectibles & Art", "Health & Beauty", "Games & Toys", "Sports & Outdoors", "Tickets"]
    let categoryOptionImages = ["tv.and.mediabox", "tshirt", "paintbrush.pointed", "figure.mind.and.body", "puzzlepiece", "football", "ticket"]
    @State var selectedCategory = 0
    
    @ObservedObject var itemsDB = UserItemsDB()
    @StateObject var photoManager = PhotoManager()
    
    var body: some View {
        ZStack {
            //            LinearGradient(gradient: Gradient(colors: [Color(hue: 0.99, saturation: 0.6, brightness: 1.7), Color(hue: 0.93, saturation: 0.29, brightness: 1.1)].reversed()), startPoint: .top, endPoint: .bottom)
            //                .ignoresSafeArea()
            VStack (alignment: .center, spacing: 30) {
                Text("Post an Item") // Post Item title
                    .bold()
                    .font(.largeTitle)
                ScrollView{
                    VStack(spacing: 20) {
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
                            .background(redColor.gradient)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                        .frame(width: 300, height: 50)
                        .bold()
                        
                        
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
                            .background(redColor.gradient)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                        .frame(width: 300, height: 50)
                        .bold()
                        
                        if (selectedImage != UIImage()){
                            TabView {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 270, height: 270)
                                        .cornerRadius(30)
                                        .shadow(radius: 15)
                                }
                            }
                            .cornerRadius(30)
                            .frame(width: 270, height: 270)
                            .tabViewStyle(PageTabViewStyle())
                            .padding([.leading, .trailing])
                        }
                        
                        VStack(alignment: .leading) {
                            // Title TextField
                            Text("Title")
                                .bold()
                            TextField("Enter the title", text: $titleField)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 4))
                                .cornerRadius(10)
                                .foregroundColor(.secondary)
                                .textFieldStyle(.roundedBorder)
                            
                            
                            
                            // Description
                            Text("Description")
                                .bold()
                            
                            // Description text field
                            TextEditor(text: $descripField)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 4))
                                .foregroundColor(.secondary)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: screenWidth - 30, height: 100)
                                .cornerRadius(10)
                            Spacer()
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading){
                                    Text("Category ")
                                        .bold()
                                    
                                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 4).background(.white).cornerRadius(10)
                                        .overlay{
                                            Picker("Option", selection: $selectedCategory) {
                                                ForEach(0..<categoryOptions.count) { index in
                                                    Text(categoryOptions[index])
                                                        .tag(index)
                                                }
                                            }
                                            .accentColor(redColor)
                                            .pickerStyle(MenuPickerStyle())
                                        }
                                        .frame(width: 2*(screenWidth - 30)/3)
                                        .foregroundColor(.secondary)
                                    
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Price")
                                        .bold()
                                    TextField("$", text: $priceField)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray))
                                        .foregroundColor(.secondary)
                                        .textFieldStyle(.roundedBorder)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        ZStack {
                            Circle()
                                .fill(redColor.gradient)
                            //                            .shadow(color: .gray, radius: 25, x: 15, y: 10)
                                .frame(height: 100)
                            Circle().fill(Color.yellow.gradient).frame(height:100).scaleEffect(self.animateButton ? 1 : 0.001)
                            
                            Text("POST")
                                .font(.system(size: 14))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .kerning(4)
                                .padding(25)
                        }
                        .animation(.linear(duration: 0.6))
                        .onLongPressGesture(minimumDuration: 0.6, pressing: { isPressed in
                            self.animateButton.toggle()
                        }, perform: {
                            if titleField.isEmpty || descripField.isEmpty || priceField.isEmpty ||
                                selectedImages.isEmpty {
                                errorAlert = true
                                showAlert = true
                            } else {
                                var imagesURLs : [String] = []
                                let path = "users/" + userID
                                
                                for i in selectedImages {
                                    let resizedImage = i.aspectFittedToHeight(200)
                                    photoManager.upload(path: path, image: resizedImage) { imageURL in
                                        if let imageURL = imageURL {
                                            imagesURLs.append(imageURL)
                                            if(imagesURLs.count == selectedImages.count) {
                                                itemsDB.addItem(price: Double(self.priceField) ?? 0.0, description: self.descripField, title: self.titleField, images: imagesURLs, category: categoryOptionImages[selectedCategory])
                                                
                                                errorAlert = false
                                                showAlert = true
                                            }
                                        } else {
                                            print ("error getting imageURL")
                                        }
                                    }
                                }
                                
                            }
                        })
                        .padding(.top, 20)
                    }
                }
                .padding(.bottom, selectedImage == UIImage() ? 0 : 100)
            }
            .frame(width: screenWidth, height: screenHeight - 100)
            .sheet(isPresented: $selectPhoto) {
                ImagePicker(sourceType: camera ? .camera : .photoLibrary, selectedImage: $selectedImage, selectedImages: $selectedImages)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(errorAlert ? "Complete all fields to post" : "Posted") ,dismissButton: .default(Text("OK")))
            }
        }
        
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
