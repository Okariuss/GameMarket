//
//  HomeScreenViewModel.swift
//  GameMarket
//
//  Created by Okan Orkun on 5.06.2024.
//

import Foundation
import UIKit

enum CellType {
    case header
    case body
}

protocol HomeScreenViewModelDelegate: BaseViewModelDelegate {
    var games: [Game] { get set }
    var topGames: [Game] { get set }
    var isSearching: Bool { get set }
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func cellType(for indexPath: IndexPath) -> CellType
    func search(_ searchBar: UISearchBar, _ searchText: String)
}

final class HomeScreenViewModel<T: HomeScreenViewControllerDelegate> {
    weak var view: T?
    private var networkManager: NetworkManager
    
    var games: [Game] = []
    var topGames: [Game] = []
    var isSearching: Bool = false
    
    init(_ networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension HomeScreenViewModel: HomeScreenViewModelDelegate {
    private func fetchGames() {
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
                        self.topGames = self.getTopGames()
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
    
    private func searchGames(query: String) {
        view?.startSpinner()
        
        guard networkManager.isConnected else {
            view?.showAlert(title: "Error", message: "No internet connection. You should connect internet for access newest games.", acceptAction: {
                self.view?.stopSpinner()
            })
            return
        }
        
        Task {
                do {
                    let data = try await networkManager.request(endpoint: .searchGame(query: query))
                    do {
                        let parsedGames = try JSONDecoder().decode(Games.self, from: data)
                        DispatchQueue.main.async {
                            self.games = parsedGames.results
                            self.view?.stopSpinner()
                            self.view?.reloadData()
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
    
    func numberOfSections() -> Int {
        return isSearching ? 1 : Section.allCases.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        if isSearching {
            return games.count
        } else {
            switch Section(rawValue: section)! {
                case .topGames: return topGames.count
                case .allGames: return games.count
            }
        }
    }
    
    func cellType(for indexPath: IndexPath) -> CellType {
        if isSearching || Section(rawValue: indexPath.section) == .allGames {
            return .body
        } else {
            return .header
        }
    }
    
    func search(_ searchBar: UISearchBar, _ searchText: String) {
        isSearching = !searchText.isEmpty
        if searchText.count > 3 {
            searchGames(query: searchText)
        } else if searchText.isEmpty {
            searchGames(query: "")
        }
    }
    
    func viewDidLoad() {
        fetchGames()
        view?.configure()
    }
    
    private func getTopGames() -> [Game] {
        return Array(games.shuffled().prefix(5))
    }
}
