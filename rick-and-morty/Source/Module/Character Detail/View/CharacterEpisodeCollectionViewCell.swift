//
//  CharacterEpisodeCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 8/9/23.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "characterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .mainGreen1
        label.text = "Season"
        return label
    }()
    
    private let episodeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Episode name"
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.text = "Air date"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


// MARK: - EXTENSIONS

private extension CharacterEpisodeCollectionViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor2
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.mainBlue1?.cgColor
        
        contentView.addSubview(seasonLabel)
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
        contentView.addSubview(episodeNameLabel)
        NSLayoutConstraint.activate([
            episodeNameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: 10),
            episodeNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            episodeNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
        ])
        contentView.addSubview(airDateLabel)
        NSLayoutConstraint.activate([
            airDateLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 5),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
}
