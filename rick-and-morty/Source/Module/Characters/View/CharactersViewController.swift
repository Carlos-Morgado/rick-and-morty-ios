//
//  CharactersViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

class CharactersViewController: UIViewController {

    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

}

// MARK: - EXTENSIONS

private extension CharactersViewController {
    func configView() {
        title = NSLocalizedString("characters_screen_navigation_title", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterTableViewCell")
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: "characterTableViewCell")
        return cell!
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

