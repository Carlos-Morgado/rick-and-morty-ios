//
//  CharactersViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

protocol CharactersView: AnyObject {
    // Presenter -> View
    func reloadCharacters()
}

final class CharactersViewController: UIViewController {
    
    var presenter: CharactersPresenter?

    private lazy var charactersSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "characters_searchbar_placeholder".localized
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.barTintColor = .clear
        searchBar.tintColor = .mainGreen1
        searchBar.searchTextField.textColor = .white
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            let placeholderColor = UIColor.mainBlue1
            let placeholderText = "characters_searchbar_placeholder".localized
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor as Any])
        }
        if let magnifyingGlassImage = UIImage(named: "lupa") {
            searchBar.setImage(magnifyingGlassImage, for: .search, state: .normal)
        }
        return searchBar
    }()
    
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
    
    func reloadCharacters() {
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
        view.addSubview(charactersSearchBar)
        NSLayoutConstraint.activate([
           charactersSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           charactersSearchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
           charactersSearchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
           charactersSearchBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        view.addSubview(charactersTableView)
        configCharactersTableView()
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: charactersSearchBar.bottomAnchor, constant: 5),
            charactersTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charactersTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        cell.setCellLabelTexts(setName: character.name, setStatus: character.status.localizedText, setSpecies: character.species, setLocation: character.location.name)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Get the height of the table content
        let heightContentTable = charactersTableView.contentSize.height
        
        // Get the current offset position
        let offsetPosition = charactersTableView.contentOffset.y
        
        // Get the height of the visible view
        let heightOfTheView = charactersTableView.frame.size.height
        
        // Determina cuántos puntos faltan para llegar al final
        let remainingPoints = heightContentTable - (offsetPosition + heightOfTheView)
        
        // Define a constant to determine how many points are considered "near the end".
        let pointsNearTheEnd: CGFloat = 100.0 // Ajusta este valor según tus necesidades
        
        if remainingPoints < pointsNearTheEnd {
            // Your are near to the end of the table
            // You can upload more data or perform the desired action here
            presenter?.getCharacters()
        }
    }
}

extension CharactersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // Here you can perform some action on the search term, such as searching a database or performing some other related task.
            presenter?.searchBarSearchButtonClicked(searchText: searchText)
        }
        searchBar.resignFirstResponder() // Hide the keyboard
    }
}
