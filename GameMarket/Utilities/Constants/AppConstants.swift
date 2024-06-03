//
//  AppConstants.swift
//  GameMarket
//
//  Created by Okan Orkun on 2.06.2024.
//

import Foundation
import UIKit

final class AppConstants {
    
    // MARK: System Images
    enum SystemImages: String {
        case house = "house"
        case favorite = "heart"
        
        var toSelected: UIImage {
            return UIImage(systemName: "\(rawValue).fill")!
        }
        
        var normal: UIImage {
            return (UIImage(systemName: rawValue)?.withRenderingMode(.alwaysOriginal).withTintColor(.white))!
        }
    }
}
