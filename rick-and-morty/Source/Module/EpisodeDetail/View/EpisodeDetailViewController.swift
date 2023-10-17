//
//  EpisodeDetailViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/9/23.
//

import UIKit

protocol EpisodeDetailView: AnyObject {
    // Presenter -> View
    func reloadData()
}

final class EpisodeDetailViewController: UIViewController {

    var presenter: EpisodeDetailPresenter?
    
    enum SectionType: CaseIterable {
        case episodeInformationSection
        case episodeCharactersSection
    }
    
    private lazy var episodeCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSections(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.register(EpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeInfoCollectionViewCell.identifier)
        collectionView.register(CharactersSectionCollectionViewCell.self, forCellWithReuseIdentifier: CharactersSectionCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        presenter?.viewDidLoad()
    }
    

}

// MARK: - EXTENSIONS

extension EpisodeDetailViewController: EpisodeDetailView {
    func reloadData() {
        episodeCollectionView.reloadData()
    }
}

extension EpisodeDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionType.allCases[section]
        switch sectionType {
        case .episodeInformationSection:
            return EpisodeTypeInfo.allCases.count
        case .episodeCharactersSection:
            return presenter?.characters.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter else {
            return UICollectionViewCell()
        }
        let episode = presenter.episode
        let sectionType = SectionType.allCases[indexPath.section]
        switch sectionType {
        case .episodeInformationSection:
            guard let episodeInfoCell = episodeCollectionView.dequeueReusableCell(withReuseIdentifier: EpisodeInfoCollectionViewCell.identifier, for: indexPath) as? EpisodeInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            episodeInfoCell.setEpisodeInfoText(title: EpisodeTypeInfo.allCases[indexPath.row].localizedText, value: presenter.getEpisodeInfoCellValue(infoType: EpisodeTypeInfo.allCases[indexPath.row]))
            return episodeInfoCell
        case .episodeCharactersSection:
            guard let episodeCharactersCell = episodeCollectionView.dequeueReusableCell(withReuseIdentifier: CharactersSectionCollectionViewCell.identifier, for: indexPath) as? CharactersSectionCollectionViewCell else {
                return UICollectionViewCell()
            }
            let character = presenter.characters[indexPath.row]
            episodeCharactersCell.setValues(characterName: character.name, characterStatus: character.status.localizedText)
            episodeCharactersCell.setCellCharacterImage(character.image)
            return episodeCharactersCell
        }
    }
}

extension EpisodeDetailViewController: UICollectionViewDelegate {

}

private extension EpisodeDetailViewController {
    func configView() {
        title = presenter?.episode.episode
        view.backgroundColor = .mainBackgroundColor1
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor1
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.addSubview(episodeCollectionView)
        NSLayoutConstraint.activate([
            episodeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            episodeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func createEpisodeInformationSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(85)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0

        return section
    }

    func createEpisodeCharactersSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.3), heightDimension: .absolute(350)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func createSections(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionType = SectionType.allCases
        switch sectionType[sectionIndex] {
        case .episodeInformationSection:
            return self.createEpisodeInformationSectionLayout()
        case .episodeCharactersSection:
            return self.createEpisodeCharactersSectionLayout()
        }
    }
}
