//
//  Message.swift
//  TerpExchange
//
//  Created by kushal on 4/17/23.
//

import Foundation

struct Message: Identifiable, Codable {
    var id = UUID()
    var fromID : String
    var text: String
    var timestamp: Date
}
