//
//  LocationInfoCollectionViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import UIKit

final class LocationInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LocationInfoCollectionViewCell"
    
    private let locationInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .mainGreen1
        return label
    }()
    
    private let locationInfoValueLabel: UILabel = {
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
    
    func setLocationInfoText(title: String, value: String) {
        locationInfoTitleLabel.text = title
        locationInfoValueLabel.text = value
    }
    
}

// MARK: - EXTENSIONS

private extension LocationInfoCollectionViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor2
        contentView.layer.cornerRadius = 7
        
        contentView.addSubview(locationInfoTitleLabel)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            locationInfoTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            locationInfoTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        contentView.addSubview(locationInfoValueLabel)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            locationInfoValueLabel.topAnchor.constraint(equalTo: locationInfoTitleLabel.bottomAnchor, constant: 10),
            locationInfoValueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
