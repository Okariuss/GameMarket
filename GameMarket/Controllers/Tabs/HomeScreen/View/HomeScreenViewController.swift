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
    func configureCollectionView()
    func reloadData()
}

final class HomeScreenViewController: UIViewController {
    
    private lazy var spinner = addSpinner(size: .large)
    
    private lazy var viewModel: HomeScreenViewModel<HomeScreenViewController> = HomeScreenViewModel()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            switch section {
            case .topGames:
                return self.createSection(itemWidthPercentage: 0.95, itemHeightPercentage: 1.0, groupWidthPercentage: 0.9, groupHeightPercentage: 0.4, scrollDirection: .horizontal, padding: .medium, spacing: .none)
            case .allGames:
                return self.createSection(itemWidthPercentage: 1.0, itemHeightPercentage: 1.0, groupWidthPercentage: 1.0, groupHeightPercentage: 0.15, scrollDirection: .vertical, padding: .medium, spacing: .small)
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
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GameHeaderCollectionViewCell.self, forCellWithReuseIdentifier: GameHeaderCollectionViewCell.identifier)
        collectionView.register(GameBodyCollectionViewCell.self, forCellWithReuseIdentifier: GameBodyCollectionViewCell.identifier)
        view.addSubviews(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Home"
        configureSpinner()
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
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .topGames:
            return viewModel.topGames.count
        case .allGames:
            return viewModel.games.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .topGames:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameHeaderCollectionViewCell.identifier, for: indexPath) as? GameHeaderCollectionViewCell else {
                fatalError("Unable to dequeue GameHeaderCollectionViewCell")
            }
            cell.configure(with: viewModel.topGames[indexPath.row])
            return cell
        case .allGames:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameBodyCollectionViewCell.identifier, for: indexPath) as? GameBodyCollectionViewCell else {
                fatalError("Unable to dequeue GameBodyCollectionViewCell")
            }
            cell.configure(with: viewModel.games[indexPath.row])
            return cell
        }
    }
}
