//
//  BaseViewControllerDelegate.swift
//  GameMarket
//
//  Created by Okan Orkun on 5.06.2024.
//

import Foundation
import UIKit

protocol BaseViewControllerDelegate: AnyObject, AlertPresentable {
    func configure()
    func navigateScreen(_ vc: UIViewController)
    func previousScreen()
}

extension BaseViewControllerDelegate where Self: UIViewController {
    func previousScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}
