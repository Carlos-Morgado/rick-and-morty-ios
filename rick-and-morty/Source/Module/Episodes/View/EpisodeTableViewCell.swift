//
//  EpisodeTableViewCell.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 16/9/23.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell {

    static let identifier: String = "EpisodeTableViewCell"
    
    private lazy var episodeCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .mainBlue1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 16)
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
    
    func setCellLabelTexts(setEpisodeCode episode: String, setEpisodeName name: String) {
        episodeCodeLabel.text = episode
        episodeNameLabel.text = name
    }

}

// MARK: - EXTENSIONS

private extension EpisodeTableViewCell {
    func configView() {
        contentView.backgroundColor = .mainBackgroundColor1
        
        contentView.addSubview(episodeCodeLabel)
        NSLayoutConstraint.activate([
            episodeCodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            episodeCodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            episodeCodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        contentView.addSubview(episodeNameLabel)
        NSLayoutConstraint.activate([
            episodeNameLabel.topAnchor.constraint(equalTo: episodeCodeLabel.bottomAnchor, constant: 5),
            episodeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            episodeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        contentView.addSubview(disclosureIndicator)
        NSLayoutConstraint.activate([
            disclosureIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
