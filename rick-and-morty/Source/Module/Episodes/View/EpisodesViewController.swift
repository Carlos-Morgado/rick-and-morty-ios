//
//  EpisodesViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

protocol EpisodesView: AnyObject {
    // Presenter -> View
    func showEpisodesList()
}

final class EpisodesViewController: UIViewController {

    var presenter: EpisodesPresenter?
    
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
    
    func showEpisodesList() {
        episodesTableView.reloadData()
    }
}

private extension EpisodesViewController {
    func configView() {
        title = "episodes_screen_navigation_title".localized
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor1
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .mainBackgroundColor1
        
        view.addSubview(episodesTableView)
        configEpisodesTableView()
        NSLayoutConstraint.activate([
            episodesTableView.topAnchor.constraint(equalTo: view.topAnchor),
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
}
