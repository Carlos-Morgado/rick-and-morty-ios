//
//  EpisodeInfoCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 20/9/23.
//

import UIKit

final class EpisodeInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EpisodeInfoCollectionViewCell"
    
    private let episodeInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .mainGreen1
        return label
    }()
    
    private let episodeInfoValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEpisodeInfoText(title: String, value: String) {
        episodeInfoTitleLabel.text = title
        episodeInfoValueLabel.text = value
    }
}

// MARK: - EXTENSIONS

private extension EpisodeInfoCollectionViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor2
        contentView.layer.cornerRadius = 7
        
        contentView.addSubview(episodeInfoTitleLabel)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            episodeInfoTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            episodeInfoTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        contentView.addSubview(episodeInfoValueLabel)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            episodeInfoValueLabel.topAnchor.constraint(equalTo: episodeInfoTitleLabel.bottomAnchor, constant: 10),
            episodeInfoValueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
