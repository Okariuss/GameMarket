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
    
    private lazy var collectionViewLayout = addCollectionViewLayout(width: .dWidth * 0.95, height: .dHeight / 8, lineSpacing: .medium)
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

    private lazy var viewModel: HomeScreenViewModel<HomeScreenViewController> = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
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
        
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameBodyCollectionViewCell.identifier, for: indexPath) as? GameBodyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.games[indexPath.row])
        return cell
    }
}
