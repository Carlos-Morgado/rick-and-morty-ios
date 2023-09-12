//
//  CharacterInfoCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 7/9/23.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "characterInfoCollectionViewCell"
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .mainBlue1
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
}

// MARK: - EXTENSIONS

private extension CharacterInfoCollectionViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor2
        contentView.layer.cornerRadius = 7
        contentView.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            statusLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
