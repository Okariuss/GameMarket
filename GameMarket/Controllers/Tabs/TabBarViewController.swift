//
//  TabBarViewController.swift
//  GameMarket
//
//  Created by Okan Orkun on 2.06.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .systemBackground
        setTabs()
    }
    
}

private extension TabBarViewController {
    private func setTabs() {
        let homeVC = generateTab(on: HomeScreenViewController(), image: AppConstants.SystemImages.house.normal.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal), selectedImage: AppConstants.SystemImages.house.toSelected.withTintColor(.label, renderingMode: .alwaysOriginal))
        
        let favoriteVC = generateTab(on: FavoriteScreenViewController(), image: AppConstants.SystemImages.favorite.normal.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal), selectedImage: AppConstants.SystemImages.favorite.toSelected.withTintColor(.label, renderingMode: .alwaysOriginal))
        
        setViewControllers([homeVC, favoriteVC], animated: true)
    }
    
    private func generateTab(on view: UIViewController, image: UIImage, selectedImage: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: view)
        nav.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
        return nav
    }
}
