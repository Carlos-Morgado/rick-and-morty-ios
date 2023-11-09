//
//  CharacterPhotoCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 12/9/23.
//

import UIKit
import Kingfisher

final class CharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setCellCharacterImage(_ image: String) {
        let characterImageURL = URL(string: image)
        imageView.kf.setImage(with: characterImageURL)
    }
}

// MARK: - EXTENSIONS

private extension CharacterPhotoCollectionViewCell {
    
    func configView() {
        contentView.backgroundColor = .gray
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
