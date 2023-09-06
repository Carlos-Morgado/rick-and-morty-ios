//
//  CharacterTableViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/8/23.
//

import UIKit
import Kingfisher

final class CharacterTableViewCell: UITableViewCell {
    private lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainBackgroundColor2
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .mainBlue1
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
    
    private lazy var characterStatusCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    private lazy var characterStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterSpeciesIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person.fill.questionmark")
        imageView.tintColor = UIColor.mainBlue1
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var characterSpeciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLocationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "globe.europe.africa.fill")
        imageView.tintColor = UIColor.mainGreen1
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var characterLocationLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "character_location_label_title".localized
        label.font = .systemFont(ofSize: 14)
        label.textColor = .mainBlue1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func setCellLabelTexts(setName name: String, setStatus status: String, setSpecies species: String , setLocation location: String) {
        characterNameLabel.text = name
        characterStatusLabel.text = status
        characterSpeciesLabel.text = species
        characterLocationLabel.text = location
    }
    
    func setCellCharacterImage(_ image: String) {
        let characterImageURL = URL(string: image)
        characterImageView.kf.setImage(with: characterImageURL)
    }
}

// MARK: - EXTENSIONS

private extension CharacterTableViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor1
        
        contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        cardView.addSubview(characterImageView)
        
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            characterImageView.widthAnchor.constraint(equalTo: cardView.heightAnchor)
        ])
        
        cardView.addSubview(characterNameLabel)
        NSLayoutConstraint.activate([
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterNameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 7)
        ])
        
        cardView.addSubview(characterStatusCircle)
        NSLayoutConstraint.activate([
            characterStatusCircle.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterStatusCircle.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 2),
            characterStatusCircle.widthAnchor.constraint(equalToConstant: 16),
            characterStatusCircle.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        cardView.addSubview(characterStatusLabel)
        NSLayoutConstraint.activate([
            characterStatusLabel.leadingAnchor.constraint(equalTo: characterStatusCircle.trailingAnchor, constant: 4),
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 2)
        ])
        
        cardView.addSubview(characterSpeciesIcon)
        NSLayoutConstraint.activate([
            characterSpeciesIcon.leadingAnchor.constraint(equalTo: characterStatusLabel.trailingAnchor, constant: 10),
            characterSpeciesIcon.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 2),
            characterSpeciesIcon.widthAnchor.constraint(equalToConstant: 18),
            characterSpeciesIcon.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        cardView.addSubview(characterSpeciesLabel)
        NSLayoutConstraint.activate([
            characterSpeciesLabel.leadingAnchor.constraint(equalTo: characterSpeciesIcon.trailingAnchor, constant: 4),
            characterSpeciesLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 2)
        ])
        
        cardView.addSubview(characterLocationIcon)
        NSLayoutConstraint.activate([
            characterLocationIcon.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterLocationIcon.topAnchor.constraint(equalTo: characterSpeciesLabel.bottomAnchor, constant: 20),
            characterLocationIcon.widthAnchor.constraint(equalToConstant: 16),
            characterLocationIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        cardView.addSubview(characterLocationLabelTitle)
        NSLayoutConstraint.activate([
            characterLocationLabelTitle.leadingAnchor.constraint(equalTo: characterLocationIcon.trailingAnchor, constant: 4),
            characterLocationLabelTitle.topAnchor.constraint(equalTo: characterSpeciesLabel.bottomAnchor, constant: 20)
        ])
        
        cardView.addSubview(characterLocationLabel)
        NSLayoutConstraint.activate([
            characterLocationLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 30),
            characterLocationLabel.topAnchor.constraint(equalTo: characterLocationLabelTitle.bottomAnchor, constant: 2)
        ])
    }
}
