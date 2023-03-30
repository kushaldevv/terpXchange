//
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
        @State var titleField = ""
        @State var categoryField = ""
        @State var descripField = ""
        @State var priceField = ""
        
        var body: some View {
            NavigationView() {
                /*NavigationLink(destination: HomeView(), label:  {
                    Text("Cancel")
                })*/
                VStack {
                    // Post item header HStack
                    HStack(spacing: 50) {
                        // Back button
                        NavigationLink(destination: HomeView().navigationBarHidden(true)
                            .navigationBarTitle(""), label:  {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.red)
                                    .font(.system(size: 30, weight: .bold))
                                .navigationBarHidden(true)
                                .navigationBarTitle("")
                        })
                        
                        // Post Item title
                        Text("Post an Item")
                            .multilineTextAlignment(.center)
                            .bold()
                        /*.font(.system(size: 30))*/
                            /*.font(.custom(
                                "Righteous-Regular",
                                fixedSize: 30))*/
                            .font(.system(size: 25))
                            .padding()
                            .foregroundStyle(
                                .linearGradient(colors: [Color(red: 238/255, green: 130/255, blue: 238/255), .red],
                                    startPoint: .leading,
                                    endPoint: .trailing))
                        
                        // Cancel button
                        NavigationLink(destination: HomeView().navigationBarHidden(true)
                            .navigationBarTitle(""), label:  {
                            Text("Cancel")
                                .navigationBarHidden(true)
                                .navigationBarTitle("")
                                .foregroundStyle(
                                    .linearGradient(colors: [Color(red: 238/255, green: 130/255, blue: 238/255), .red],
                                        startPoint: .leading,
                                        endPoint: .trailing))
                                
                        })
                    }
                    .offset(y: -20)
                    
                    
                    // Photo VStack
                    VStack {
                        // Take Photo button
                        Button(action: {
                            // do something
                        }) {
                            Capsule()
                                .fill(.gray)
                                .frame(width: 300, height: 50)
                                .opacity(0.4)
                                .overlay(Text("Take Photo")
                                    .bold()
                                    .foregroundColor(Color.red)
                                    .font(.custom(
                                        "Righteous-Regular",
                                        fixedSize: 20)))
                                .offset(y:-150)
                        }
                        
                        // Select Photo
                        Capsule()
                            .fill(.gray)
                            .frame(width: 300, height: 50)
                            .opacity(0.4)
                            .overlay(Text("Select Photo")
                                .bold()
                                .foregroundColor(Color.red)
                                .font(.custom(
                                    "Righteous-Regular",
                                    fixedSize: 20)))
                            .offset(y:-150)
                        
                        
                    }
                    .offset(y: 130)
                    
                    // VStack for all the user input
                    VStack {
                        
                        // Title
                        Text("Title")
                            .offset(x: -150, y: -80)
                            .bold()
                        
                        // Title Text Field
                        TextField("Title", text: $titleField)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                            .frame(width: 340)
                            .offset(x: 1, y:-85)
                            .textFieldStyle(.roundedBorder)
                        
                        // Title Text blurb
                        Text("For example: Item name")
                            .offset(x: -90, y:-90)
                            .font(.system(size: 14))
                            .foregroundColor(Color.gray)
                        
                        // Category
                        Text("Category")
                            .offset(x: -130, y: -70)
                            .bold()
                        
                        // Category text field
                        TextField("Category", text: $categoryField)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                            .frame(width: 340)
                            .offset(x: 1, y:-75)
                            .textFieldStyle(.roundedBorder)
                        
                        // Description
                        Text("Description")
                            .offset(x: -120, y: -61)
                            .bold()
                        
                        // Description text field
                        TextEditor(text: $descripField)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            //.navigationTitle("Description")
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 370, height: 200)
                            .offset(x: 1, y: -68)
        
                        // Price
                        Text("Price")
                            .bold()
                            .offset(x: -145, y: -60)
                        
                        // Price text field
                        TextField("Price", text: $priceField)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                            .keyboardType(.numberPad) // only numbers
                            .frame(width: 340)
                            .offset(x: 1, y: -65)
                            .textFieldStyle(.roundedBorder)
                        
                        // Post button
                        Button(action: {
                            // do something
                        }) {
                            Capsule()
                                .fill(.red)
                                .frame(width: 100, height: 30)
                                .overlay(Text("Post")
                                    .bold()
                                    .foregroundColor(Color.white)
                                    .font(.custom(
                                        "Righteous-Regular",
                                        fixedSize: 20)))
                                .offset(x: -2,y: -40)
                        }
                    }
                    .offset(y:60)
                }
            }
        }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
