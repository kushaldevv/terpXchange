//
//  RootUIViewController.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/14/23.
//

import Foundation
import SwiftUI

final class RootUIViewController {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
