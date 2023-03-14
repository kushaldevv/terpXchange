//
//  Application.swift
//  TerpExchange
//
//  Created by Ryan Abeysinghe on 3/13/23.
//

import Foundation
import SwiftUI
import UIKit

final class ApplicationUtility {
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
