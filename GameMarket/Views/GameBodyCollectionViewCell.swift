//
//  GameBodyCollectionViewCell.swift
//  GameMarket
//
//  Created by Okan Orkun on 6.06.2024.
//

import UIKit
import Kingfisher

final class GameBodyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GameBodyCollectionViewCell"
    
    private lazy var gameImageView = UIViewController().addImageView(cornerRadius: .small)
    
    private lazy var nameLabel = UIViewController().addLabel(alignment: .left, font: .body, isBold: true)
    
    private lazy var releasedLabel = UIViewController().addLabel(color: .secondaryLabel, alignment: .left, font: .caption)
    
    private lazy var ratingProgress = UIViewController().addCircularProgress()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .quaternarySystemFill
        contentView.layer.cornerRadius = 10
        contentView.addSubviews(gameImageView, nameLabel, releasedLabel, ratingProgress)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.kf.cancelDownloadTask()
        gameImageView.image = nil
        nameLabel.text = nil
        releasedLabel.text = nil
        ratingProgress.resetProgress()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppConstants.Spacing.small.rawValue),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppConstants.Spacing.small.rawValue),
            gameImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -AppConstants.Spacing.small.rawValue),
            gameImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height * 0.8),
            gameImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.8),
                        
            nameLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: AppConstants.Spacing.small.rawValue),
            nameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: AppConstants.Spacing.small.rawValue),
            
            releasedLabel.bottomAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: -AppConstants.Spacing.small.rawValue),
            releasedLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: AppConstants.Spacing.small.rawValue),
            
            ratingProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppConstants.Spacing.small.rawValue),
            ratingProgress.bottomAnchor.constraint(equalTo: gameImageView.bottomAnchor),
            ratingProgress.widthAnchor.constraint(equalToConstant: contentView.bounds.height / 2.5),
            ratingProgress.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 2.5)
        ])
    }
    
    func configure(with game: Game) {
        nameLabel.text = game.name
        releasedLabel.text = "Released: \(game.released)"
        gameImageView.kf.setImage(with: URL(string: game.background_image))
        ratingProgress.progress = CGFloat(game.rating)
    }
}
