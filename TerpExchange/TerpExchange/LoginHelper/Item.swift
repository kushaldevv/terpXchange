//
//  Item.swift
//  TerpExchange
//
//  Created by kushal on 4/14/23.
//

import Foundation
import SwiftUI

class Item {
    let id: UUID
    let userID: String
    let image: Image
    let date:  Date
    let title: String
    let description: String
    let price: Double
    
    init(userID: String, image: Image, title: String, description: String, price: Double) {
        self.id = UUID()
        self.userID = userID
        self.image = image
        self.date = Date()
        self.title = title
        self.description = description
        self.price = price
    }
}

var items = Array(repeating: Item(userID: "test", image: Image("rubix"), title: "Rubix Cube", description: "Lorem Ipsum", price: 10.50), count: 25)
