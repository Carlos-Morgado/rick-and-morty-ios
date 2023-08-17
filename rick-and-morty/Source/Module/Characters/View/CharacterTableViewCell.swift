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
    
    private lazy var characterImageViewAPI: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .mainBlue1
        return imageView
    }()
    
    private lazy var characterNameLabelAPI: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.textColor = .mainGreen1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterStatusLabelAPI: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLocationLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "Last known location:"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainBlue1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLocationLabelAPI: UILabel = {
        let label = UILabel()
        label.text = "Location given by the API"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterEpisodeLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "First seen in:"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .mainBlue1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterEpisodeLabelAPI: UILabel = {
        let label = UILabel()
        label.text = "Episode given by the API"
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        cardView.addSubviews(characterImageViewAPI, characterNameLabelAPI, characterStatusLabelAPI, characterLocationLabelTitle, characterLocationLabelAPI, characterEpisodeLabelTitle, characterEpisodeLabelAPI)
        NSLayoutConstraint.activate([
            characterImageViewAPI.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            characterImageViewAPI.topAnchor.constraint(equalTo: cardView.topAnchor),
            characterImageViewAPI.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            characterImageViewAPI.widthAnchor.constraint(equalTo: cardView.heightAnchor),
            
            characterNameLabelAPI.leadingAnchor.constraint(equalTo: characterImageViewAPI.trailingAnchor, constant: 10),
            characterNameLabelAPI.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 7),
            
            characterStatusLabelAPI.leadingAnchor.constraint(equalTo: characterImageViewAPI.trailingAnchor, constant: 10),
            characterStatusLabelAPI.topAnchor.constraint(equalTo: characterNameLabelAPI.bottomAnchor, constant: 2),
            
            characterLocationLabelTitle.leadingAnchor.constraint(equalTo: characterImageViewAPI.trailingAnchor, constant: 10),
            characterLocationLabelTitle.topAnchor.constraint(equalTo: characterStatusLabelAPI.bottomAnchor, constant: 10),
            
            characterLocationLabelAPI.leadingAnchor.constraint(equalTo: characterImageViewAPI.trailingAnchor, constant: 10),
            characterLocationLabelAPI.topAnchor.constraint(equalTo: characterLocationLabelTitle.bottomAnchor, constant: 2),
            
            characterEpisodeLabelTitle.leadingAnchor.constraint(equalTo: characterImageViewAPI.trailingAnchor, constant: 10),
            characterEpisodeLabelTitle.topAnchor.constraint(equalTo: characterLocationLabelAPI.bottomAnchor, constant: 10),
            
            characterEpisodeLabelAPI.leadingAnchor.constraint(equalTo: characterImageViewAPI.trailingAnchor, constant: 10),
            characterEpisodeLabelAPI.topAnchor.constraint(equalTo: characterEpisodeLabelTitle.bottomAnchor, constant: 2)
            
        ])
    }
    
}
