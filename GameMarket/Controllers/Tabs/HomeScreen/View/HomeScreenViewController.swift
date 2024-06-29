//
//  HomeScreenViewController.swift
//  GameMarket
//
//  Created by Okan Orkun on 2.06.2024.
//

import UIKit

protocol HomeScreenViewControllerDelegate: BaseViewControllerDelegate {
    func configureSpinner()
    func startSpinner()
    func stopSpinner()
    func configureSearchBar()
    func configureCollectionView()
    func reloadData()
}

final class HomeScreenViewController: UIViewController {
    
    private lazy var spinner = addSpinner(size: .large)
    
    private lazy var viewModel: HomeScreenViewModel<HomeScreenViewController> = HomeScreenViewModel()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private lazy var searchBar = addSearchBar(placeholder: L10N.searchBarPlaceholder)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            if self.viewModel.isSearching {
                return self.createSection(itemWidthPercentage: 1.0, itemHeightPercentage: 1.0, groupWidthPercentage: 1.0, groupHeightPercentage: 0.15, scrollDirection: .vertical, padding: .medium, spacing: .small)
            } else {
                guard let section = Section(rawValue: sectionIndex) else { return nil }
                switch section {
                case .topGames:
                    return self.createSection(itemWidthPercentage: 0.95, itemHeightPercentage: 1.0, groupWidthPercentage: 0.9, groupHeightPercentage: 0.4, scrollDirection: .horizontal, padding: .medium, spacing: .none)
                case .allGames:
                    return self.createSection(itemWidthPercentage: 1.0, itemHeightPercentage: 1.0, groupWidthPercentage: 1.0, groupHeightPercentage: 0.15, scrollDirection: .vertical, padding: .medium, spacing: .small)
                }
            }
        }
        return layout
    }
}

extension HomeScreenViewController: HomeScreenViewControllerDelegate {
    func configureSpinner() {
        view.bringSubviewToFront(spinner)
        view.addSubviews(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    func startSpinner() {
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        view.addSubviews(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureCollectionView() {
        view.addSubviews(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        if !viewModel.isSearching {
            collectionView.register(GameHeaderCollectionViewCell.self, forCellWithReuseIdentifier: GameHeaderCollectionViewCell.identifier)
        }
        collectionView.register(GameBodyCollectionViewCell.self, forCellWithReuseIdentifier: GameBodyCollectionViewCell.identifier)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Home"
        configureSpinner()
        configureSearchBar()
        configureCollectionView()
    }
    
    func navigateScreen(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.cellType(for: indexPath) {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameHeaderCollectionViewCell.identifier, for: indexPath) as? GameHeaderCollectionViewCell else {
                fatalError("Unable to dequeue GameHeaderCollectionViewCell")
            }
            cell.configure(with: viewModel.topGames[indexPath.row])
            return cell
        case .body:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameBodyCollectionViewCell.identifier, for: indexPath) as? GameBodyCollectionViewCell else {
                fatalError("Unable to dequeue GameHeaderCollectionViewCell")
            }
            cell.configure(with: viewModel.games[indexPath.row])
            return cell
        }
    }
}

extension HomeScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchBar, searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.search(searchBar, searchBar.text!)
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
