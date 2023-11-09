//
//  LocationDetailViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import UIKit

protocol LocationDetailView: AnyObject {
    // Presenter -> View
    func reloadData()
}

final class LocationDetailViewController: UIViewController {

    var presenter: LocationDetailPresenter?
    
    private lazy var locationCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSections(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.register(LocationInfoCollectionViewCell.self, forCellWithReuseIdentifier: LocationInfoCollectionViewCell.identifier)
        collectionView.register(CharactersSectionCollectionViewCell.self, forCellWithReuseIdentifier: CharactersSectionCollectionViewCell.identifier)
        return collectionView
    }()
    
    enum SectionType: CaseIterable {
        case locationInformationSection
        case locationResidentsSection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        presenter?.viewDidLoad()
    }

}


// MARK: - EXTENSIONS

extension LocationDetailViewController: LocationDetailView {
    func reloadData() {
        locationCollectionView.reloadData()
    }
}

extension LocationDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionType.allCases[section]
        switch sectionType {
        case .locationInformationSection:
            return EpisodeTypeInfo.allCases.count
        case .locationResidentsSection:
            return presenter?.residents.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter else {
            return UICollectionViewCell()
        }
        let sectionType = SectionType.allCases[indexPath.section]
        switch sectionType {
        case .locationInformationSection:
            guard let locationInfoCell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: LocationInfoCollectionViewCell.identifier, for: indexPath) as? LocationInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            locationInfoCell.setLocationInfoText(title: LocationTypeInfo.allCases[indexPath.row].localizedText, value: presenter.getLocationInfoCellValue(infoValue: LocationTypeInfo.allCases[indexPath.row]))
            return locationInfoCell
        case .locationResidentsSection:
            guard let locationResidentsCell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: CharactersSectionCollectionViewCell.identifier, for: indexPath) as? CharactersSectionCollectionViewCell else {
                return UICollectionViewCell()
            }
            let character = presenter.residents[indexPath.row]
            locationResidentsCell.setValues(characterName: character.name, characterStatus: character.status.localizedText)
            locationResidentsCell.setCellCharacterImage(character.image)
            return locationResidentsCell
        }
    }
}

extension LocationDetailViewController: UICollectionViewDelegate {

}

private extension LocationDetailViewController {
    func configView() {
        title = presenter?.location.name
        view.backgroundColor = .mainBackgroundColor1
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor1
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.addSubview(locationCollectionView)
        NSLayoutConstraint.activate([
            locationCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            locationCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            locationCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func createLocationInformationSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(85)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0

        return section
    }

    func createLocationResidentsSectionLayout() -> NSCollectionLayoutSection {
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
        case .locationInformationSection:
            return self.createLocationInformationSectionLayout()
        case .locationResidentsSection:
            return self.createLocationResidentsSectionLayout()
        }
    }
}
