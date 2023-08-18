//
//  CharacterTableViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/8/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    private lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainBackgroundColor2
        view.layer.cornerRadius = 6
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
        label.text = NSLocalizedString("character_name_label_card", comment: "")
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.textColor = .mainGreen1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterStatusLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("character_status_label_card", comment: "")
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLocationLabelTitle: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("character_location_label_title", comment: "")
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainBlue1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLocationLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("character_location_label_result", comment: "")
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterEpisodeLabelTitle: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("character_episode_label_title", comment: "")
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainBlue1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterEpisodeLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("character_episode_label_result", comment: "")
        label.font = .systemFont(ofSize: 12, weight: .semibold)
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
}

// MARK: - EXTENSIONS

private extension CharacterTableViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor1
        contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
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
        cardView.addSubview(characterStatusLabel)
        NSLayoutConstraint.activate([
            characterStatusLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 2)
        ])
        cardView.addSubview(characterLocationLabelTitle)
        NSLayoutConstraint.activate([
            characterLocationLabelTitle.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterLocationLabelTitle.topAnchor.constraint(equalTo: characterStatusLabel.bottomAnchor, constant: 10)
        ])
        cardView.addSubview(characterLocationLabel)
        NSLayoutConstraint.activate([
            characterLocationLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterLocationLabel.topAnchor.constraint(equalTo: characterLocationLabelTitle.bottomAnchor, constant: 2)
        ])
        cardView.addSubview(characterEpisodeLabelTitle)
        NSLayoutConstraint.activate([
            characterEpisodeLabelTitle.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterEpisodeLabelTitle.topAnchor.constraint(equalTo: characterLocationLabel.bottomAnchor, constant: 10)
        ])
        cardView.addSubview(characterEpisodeLabel)
        NSLayoutConstraint.activate([
            characterEpisodeLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            characterEpisodeLabel.topAnchor.constraint(equalTo: characterEpisodeLabelTitle.bottomAnchor, constant: 2)
        ])
    }
}
