//
//  HomeScreenViewModel.swift
//  GameMarket
//
//  Created by Okan Orkun on 5.06.2024.
//

import Foundation

protocol HomeScreenViewModelDelegate: BaseViewModelDelegate {
    var games: [Game] { get set }
    func fetchGames()
    func getGame(indexPath: IndexPath)
}

final class HomeScreenViewModel<T: HomeScreenViewControllerDelegate> {
    weak var view: T?
    private var networkManager: NetworkManager
    private var _games: [Game] = []
    
    init(_ networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension HomeScreenViewModel: HomeScreenViewModelDelegate {
    var games: [Game] {
        get {
            _games
        }
        set {
            _games = newValue
        }
    }
    
    func fetchGames() {
        view?.startSpinner()
        
        guard networkManager.isConnected else {
            view?.showAlert(title: "Error", message: "No internet connection. You should connect internet for access newest games.", acceptAction: {
                self.view?.stopSpinner()
            })
            return
        }
        
        Task {
            do {
                let data = try await networkManager.request(endpoint: .getGames)
                if let parsedGames = try? JSONDecoder().decode(Games.self, from: data) {
                    DispatchQueue.main.async {
                        self.games = parsedGames.results
                        self.view?.stopSpinner()
                        self.view?.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view?.showAlert(title: "Error", message: "Failed to parse games data.", acceptAction: {
                            self.view?.stopSpinner()
                        })
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.view?.showAlert(title: "\(error)", message: error.localizedDescription, acceptAction: {
                        self.view?.stopSpinner()
                    })
                }
            }
        }
    }
    
    func getGame(indexPath: IndexPath) {
        
    }
    
    func viewDidLoad() {
        fetchGames()
        view?.configure()
    }
}
