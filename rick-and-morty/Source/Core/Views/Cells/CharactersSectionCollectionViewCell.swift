//
//  CharactersSectionCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 17/10/23.
//

import UIKit
import Kingfisher

final class CharactersSectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharactersSectionCollectionViewCell"
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 0
        label.textColor = .mainGreen1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    func setValues(characterName: String, characterStatus: String) {
        characterNameLabel.text = characterName
        characterStatusLabel.text = characterStatus
    }
    
    func setCellCharacterImage(_ image: String) {
        let characterImageURL = URL(string: image)
        characterImageView.kf.setImage(with: characterImageURL)
    }
}

// MARK: - EXTENSIONS

private extension CharactersSectionCollectionViewCell {
    func configView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .mainBackgroundColor2
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.mainBlue1.cgColor
        
        contentView.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            characterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        contentView.addSubview(characterNameLabel)
        NSLayoutConstraint.activate([
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10),
            characterNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            characterNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
        
        contentView.addSubview(characterStatusLabel)
        NSLayoutConstraint.activate([
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 10),
            characterStatusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            characterStatusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
}
