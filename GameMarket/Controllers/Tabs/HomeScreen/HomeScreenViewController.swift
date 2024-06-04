//
//  HomeScreenViewController.swift
//  GameMarket
//
//  Created by Okan Orkun on 2.06.2024.
//

import UIKit

final class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Home"
        testNetworkRequest()
    }
    
    private func testNetworkRequest() {
        Task {
            do {
                let data = try await NetworkManager.shared.request(endpoint: .getGames)
                print("Data \(data)")
            } catch {
                print("Error \(error)")
            }
        }
    }
}
