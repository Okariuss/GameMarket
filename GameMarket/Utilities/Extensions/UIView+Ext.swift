//
//  UIView+Ext.swift
//  GameMarket
//
//  Created by Okan Orkun on 5.06.2024.
//

import UIKit

extension UIView {
    /// This function add subviews to view with translatesAutoresizingMaskIntoConstraints = false
    /// - Parameter views: Enter all views that you have
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
