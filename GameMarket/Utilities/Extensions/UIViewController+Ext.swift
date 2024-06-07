//
//  UIViewController+Ext.swift
//  GameMarket
//
//  Created by Okan Orkun on 5.06.2024.
//

import UIKit

extension UIViewController {
    
    // MARK: - Label
    
    /// Creates and configures a UILabel.
    ///
    /// - Parameters:
    ///   - text: The text to display in the label. Default is an empty string.
    ///   - color: The text color of the label. Default is the label color.
    ///   - alignment: The alignment of the text in the label.
    ///   - font: The font size of the label.
    ///   - isBold: Indicates whether the text should be bold. Default is false.
    ///
    /// - Returns: A configured UILabel instance.
    func addLabel(text: String? = "", color: UIColor? = .label, alignment: NSTextAlignment, font: AppConstants.FontSize, isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.textColor = color
        label.textAlignment = alignment
        label.font = isBold ? font.toFont.boldVersion : font.toFont
        return label
    }
    
    // MARK: - ImageView
    
    /// Creates and configures a UIImageView.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius of the image view.
    ///
    /// - Returns: A configured UIImageView instance.
    func addImageView(cornerRadius: AppConstants.CornerRadius) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius.rawValue
        return imageView
    }
    
    // MARK: - Spinner
    
    /// Creates and configures a UIActivityIndicatorView.
    ///
    /// - Parameters:
    ///   - size: The size of the spinner.
    ///   - style: The style of the spinner.
    ///
    /// - Returns: A configured UIActivityIndicatorView instance.
    func addSpinner(size style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = style
        return spinner
    }
    
    // MARK: - Circular Progress View
    
    /// Creates a CircularProgressView instance.
    ///
    /// - Returns: A CircularProgressView instance.
    func addCircularProgress() -> CircularProgressView {
        return CircularProgressView()
    }
    
    // MARK: - Collection View Layout
    
    /// Creates and configures a UICollectionViewFlowLayout.
    ///
    /// - Parameters:
    ///   - width: The width of each item in the collection view.
    ///   - height: The height of each item in the collection view.
    ///   - lineSpacing: The spacing between lines in the collection view.
    ///
    /// - Returns: A configured UICollectionViewFlowLayout instance.
    func addCollectionViewLayout(width: CGFloat, height: CGFloat, lineSpacing: AppConstants.Spacing) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = lineSpacing.rawValue
        return layout
    }
}
