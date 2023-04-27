//
//  PhotoManager.swift
//  TerpExchange
//
//  Created by kushal on 4/24/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import Foundation

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

class PhotoManager: ObservableObject {
    let storage = Storage.storage()
    
    func upload(path: String, image: UIImage, completion: @escaping (String?) -> Void) {
        let imageUID = UUID().uuidString
        let imageRef = storage.reference().child(path + "/" + imageUID)
        
        let data = image.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            let uploadTask = imageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                    completion(nil)
                    return
                }
            }
            
            uploadTask.observe(.success) { snapshot in
                imageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting image URL: \(error.localizedDescription)")
                        completion(nil)
                        return
                    }
                    
                    guard let downloadURL = url else {
                        completion(nil)
                        return
                    }
                    
                    let imageURL = downloadURL.absoluteString
                    print("Download URL: \(imageURL)")
                    completion(imageURL)
                }
            }
        } else {
            completion(nil)
        }
    }
}
