//
//  EpisodesViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

protocol EpisodesView: AnyObject {
    // Presenter -> View
    func reloadEpisodes()
}

final class EpisodesViewController: UIViewController {

    var presenter: EpisodesPresenter?
    
    private lazy var episodesSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "episodes_searchbar_placeholder".localized
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.barTintColor = .clear
        searchBar.tintColor = .mainGreen1
        searchBar.searchTextField.textColor = .white
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            let placeholderColor = UIColor.mainBlue1
            let placeholderText = "episodes_searchbar_placeholder".localized
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor as Any])
        }
        if let magnifyingGlassImage = UIImage(named: "lupa") {
            searchBar.setImage(magnifyingGlassImage, for: .search, state: .normal)
        }
        return searchBar
    }()
    
    private lazy var episodesTableView: UITableView = {
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

extension EpisodesViewController: EpisodesView {
    
    func reloadEpisodes() {
        episodesTableView.reloadData()
    }
}

private extension EpisodesViewController {
    func configView() {
        title = "episodes_screen_navigation_title".localized
        
        view.backgroundColor = .mainBackgroundColor1
        view.addSubview(episodesSearchBar)
        NSLayoutConstraint.activate([
            episodesSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodesSearchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            episodesSearchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            episodesSearchBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        view.addSubview(episodesTableView)
        configEpisodesTableView()
        NSLayoutConstraint.activate([
            episodesTableView.topAnchor.constraint(equalTo: episodesSearchBar.bottomAnchor, constant: 5),
            episodesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            episodesTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            episodesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configEpisodesTableView() {
        episodesTableView.dataSource = self
        episodesTableView.delegate = self
        episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        episodesTableView.isScrollEnabled = true
        episodesTableView.backgroundColor = .clear
        episodesTableView.layer.cornerRadius = 0
    }
}

extension EpisodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.episodes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = episodesTableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier) as? EpisodeTableViewCell, let episode = presenter?.episodes[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellLabelTexts(setEpisodeCode: episode.episode, setEpisodeName: episode.name)
        return cell
    }
    
    
}

extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Get the height of the table content
        let heightContentTable = episodesTableView.contentSize.height
        
        // Get the current offset position
        let offsetPosition = episodesTableView.contentOffset.y
        
        // Get the height of the visible view
        let heightOfTheView = episodesTableView.frame.size.height
        
        // Determine how many points are left to go to the end
        let remainingPoints = heightContentTable - (offsetPosition + heightOfTheView)
        
        // Define a constant to determine how many points are considered "near the end".
        let pointsNearTheEnd: CGFloat = 100.0 // Adjust this value according to your needs
        
        if remainingPoints < pointsNearTheEnd {
            // You are near to the end of the table
            // You can upload more data or perform the desired action here
            presenter?.getEpisodes()
        }
    }
}

extension EpisodesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // Here you can perform some action on the search term, such as searching a database or performing some other related task.
            presenter?.searchBarSearchButtonClicked(searchText: searchText)
        }
        searchBar.resignFirstResponder() // Hide the keyboard
    }
}
