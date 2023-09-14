//
//  CharacterDetailViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 6/9/23.
//

import UIKit

protocol CharacterDetailView: AnyObject {
    
    
}

final class CharacterDetailViewController: UIViewController {
    
    var presenter: CharacterDetailPresenter?
    
    enum SectionType: CaseIterable {
        case characterPhotoSection
        case characterInformationSection
        case characterEpisodesSection
    }
    
    private lazy var characterCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSections(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.register(CharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterPhotoCollectionViewCell.identifier)
        collectionView.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.identifier)
        collectionView.register(CharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
    }
}


// MARK: - EXTENSIONS

extension CharacterDetailViewController: CharacterDetailView {
    
}

private extension CharacterDetailViewController {
    func configView() {
        title = presenter?.character.name
        view.backgroundColor = .mainBackgroundColor1
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor1
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.addSubview(characterCollectionView)
        NSLayoutConstraint.activate([
            characterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.8)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createInformationSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(95)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0

        return section
    }

    func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 7)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.3), heightDimension: .absolute(115)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func createSections(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionType = SectionType.allCases
        switch sectionType[sectionIndex] {
        case .characterPhotoSection:
            return self.createPhotoSectionLayout()
        case .characterInformationSection:
            return self.createInformationSectionLayout()
        case .characterEpisodesSection:
            return self.createEpisodesSectionLayout()
        }
    }
}

extension CharacterDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionType.allCases[section]
        switch sectionType {
        case .characterPhotoSection:
            return 1
        case .characterInformationSection:
            return CharacterTypeInfo.allCases.count
        case .characterEpisodesSection:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter else {
            return UICollectionViewCell()
        }
        let character = presenter.character
        let sectionType = SectionType.allCases[indexPath.section]
        switch sectionType {
        case .characterPhotoSection:
            guard let photoCell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: CharacterPhotoCollectionViewCell.identifier, for: indexPath) as? CharacterPhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            photoCell.setCellCharacterImage(character.image)
            return photoCell
        case .characterInformationSection:
            guard let infoCell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as? CharacterInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            infoCell.setCharacterInfoText(title: CharacterTypeInfo.allCases[indexPath.row].localizedText, value: presenter.getInfoCellValue(infoType: CharacterTypeInfo.allCases[indexPath.row]))
            return infoCell
        case .characterEpisodesSection:
            guard let episodeCell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: CharacterEpisodeCollectionViewCell.identifier, for: indexPath) as? CharacterEpisodeCollectionViewCell else {
                return UICollectionViewCell()
            }
            return episodeCell
        }
    }
    
    
}

extension CharacterDetailViewController: UICollectionViewDelegate {

}






