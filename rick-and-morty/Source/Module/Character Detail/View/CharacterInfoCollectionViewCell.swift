//
//  CharacterInfoCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 7/9/23.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "characterInfoCollectionViewCell"
    
    private let characterInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .mainBlue1
        return label
    }()
    
    private let characterInfoValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
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
    
    func setCharacterInfoText(title: String, value: String) {
        characterInfoTitleLabel.text = title
        characterInfoValueLabel.text = value
    }
}

// MARK: - EXTENSIONS

private extension CharacterInfoCollectionViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor2
        contentView.layer.cornerRadius = 7
        contentView.addSubview(characterInfoTitleLabel)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            characterInfoTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            characterInfoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            characterInfoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        contentView.addSubview(characterInfoValueLabel)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            characterInfoValueLabel.topAnchor.constraint(equalTo: characterInfoTitleLabel.bottomAnchor, constant: 10),
            characterInfoValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            characterInfoValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
