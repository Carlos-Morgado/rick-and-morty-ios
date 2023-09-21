//
//  LocationTableViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {

    static let identifier: String = "LocationTableViewCell"
    
    private lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .mainBlue1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.tintColor = .mainGreen1
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellLabelTexts(setLocationName name: String, setLocationType type: String) {
        locationNameLabel.text = name
        var locationType = "location_type_label".localized
        locationTypeLabel.text = "\(locationType) \(type)"
    }
}

// MARK: - EXTENSIONS

private extension LocationTableViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor1
        
        contentView.addSubview(locationNameLabel)
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            locationNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        contentView.addSubview(locationTypeLabel)
        NSLayoutConstraint.activate([
            locationTypeLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 5),
            locationTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        contentView.addSubview(disclosureIndicator)
        NSLayoutConstraint.activate([
            disclosureIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
