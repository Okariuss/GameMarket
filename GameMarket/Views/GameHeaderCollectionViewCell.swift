//
//  GameHeaderCollectionViewCell.swift
//  GameMarket
//
//  Created by Okan Orkun on 8.06.2024.
//

import UIKit
import Kingfisher

final class GameHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GameHeaderCollectionViewCell"
    
    private lazy var gameImageView = UIViewController().addImageView(cornerRadius: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .quaternarySystemFill
        contentView.layer.cornerRadius = AppConstants.CornerRadius.medium.rawValue
        contentView.addSubviews(gameImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.kf.cancelDownloadTask()
        gameImageView.image = nil
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            gameImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gameImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gameImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height * 0.9),
            gameImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.9)
        ])
    }
    
    func configure(with game: Game) {
        gameImageView.kf.setImage(with: URL(string: game.background_image))
    }
}
