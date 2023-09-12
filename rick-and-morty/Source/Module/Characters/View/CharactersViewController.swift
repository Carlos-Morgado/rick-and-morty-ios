//
//  CharactersViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

protocol CharactersView: AnyObject {
    // Presenter -> View
    func showCharactersList()
}

final class CharactersViewController: UIViewController {
    
    var presenter: CharactersPresenter?

    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        presenter?.viewDidLoad()
    }

}

// MARK: - EXTENSIONS

extension CharactersViewController: CharactersView {
    
    func showCharactersList() {
        charactersTableView.reloadData()
    }
}

private extension CharactersViewController {
    func configView() {
        title = "characters_screen_navigation_title".localized
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor1
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .mainBackgroundColor1
        view.addSubview(charactersTableView)
        configCharactersTableView()
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charactersTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charactersTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configCharactersTableView() {
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.isScrollEnabled = true
        charactersTableView.backgroundColor = .clear
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterTableViewCell")
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = charactersTableView.dequeueReusableCell(withIdentifier: "characterTableViewCell") as? CharacterTableViewCell, let character = presenter?.characters[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellLabelTexts(setName: character.name, setStatus: character.status.fixedText, setSpecies: character.species, setLocation: character.location.name)
        cell.setCellCharacterImage(character.image)
        return cell
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath) 
    }
}

