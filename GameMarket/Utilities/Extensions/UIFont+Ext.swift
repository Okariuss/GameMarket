//
//  UIFont+Ext.swift
//  GameMarket
//
//  Created by Okan Orkun on 7.06.2024.
//

import Foundation
import UIKit

extension UIFont {
    /// Returns the bold version of the font.
    ///
    /// - Returns: A UIFont instance representing the bold version of the font, or the original font if bold version is not available.
    var boldVersion: UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: .zero)
    }
}
