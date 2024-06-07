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
        /// House icon
        case house = "house"
        /// Favorite icon
        case favorite = "heart"
        
        var toSelected: UIImage {
            return UIImage(systemName: "\(rawValue).fill")!
        }
        
        var normal: UIImage {
            return (UIImage(systemName: rawValue)?.withRenderingMode(.alwaysOriginal).withTintColor(.white))!
        }
    }
    
    // MARK: Network Constants
    enum NetworkConstants: String {
        // Base Url
        case baseURL = "https://api.rawg.io/api/"
        
        // paths
        case games = "games"
        static var date: String {
            return "?dates=1900-01-01,\(Date().toYYYYMMDD())"
        }
        
        // api key
        case apiKey = "&key=095b135847544fb481fa5083f7858961"
    }
    
    // MARK: Font Sizes
    enum FontSize: CGFloat {
        /// Extra large title font size (48)
        case extraLargeTitle = 48
        /// Large title font size (28)
        case largeTitle = 28
        /// Title font size (22)
        case title = 22
        /// Medium title font size (20)
        case mediumTitle = 20
        
        /// Body font size (17)
        case body = 17
        /// Caption font size (15)
        case caption = 15
        
        /// Small font size (13)
        case small = 13
        /// Extra small font size (11)
        case extraSmall = 11
        
        var toFont: UIFont {
            return .systemFont(ofSize: rawValue)
        }
    }
    
    // MARK: Spaces
    enum Spacing: CGFloat {
        /// Small spacing (8)
        case small = 8
        /// Medium spacing (16)
        case medium = 16
        /// Large spacing (24)
        case large = 24
        /// Extra large spacing (32)
        case extraLarge = 32
    }
    
    // MARK: Corner Radiuses
    enum CornerRadius: CGFloat {
        /// No corner radius
        case none = 0
        /// Small corner radius (8)
        case small = 8
        /// Medium corner radius (12)
        case medium = 12
        /// Large corner radius (16)
        case large = 16
        /// Extra large corner radius (32)
        case extraLarge = 32
    }
}

