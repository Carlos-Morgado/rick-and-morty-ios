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
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor1
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
        // Obtén la altura del contenido de la tabla
        let contenidoTablaAltura = episodesTableView.contentSize.height
        
        // Obtén la posición actual de desplazamiento
        let posicionDesplazamiento = episodesTableView.contentOffset.y
        
        // Obtén la altura de la vista visible
        let vistaAltura = episodesTableView.frame.size.height
        
        // Determina cuántos puntos faltan para llegar al final
        let puntosRestantes = contenidoTablaAltura - (posicionDesplazamiento + vistaAltura)
        
        // Define una constante para determinar cuántos puntos se consideran "cerca del final"
        let puntosCercaDelFinal: CGFloat = 100.0 // Ajusta este valor según tus necesidades
        
        if puntosRestantes < puntosCercaDelFinal {
            // Estás cerca del final de la tabla
            // Puedes cargar más datos o realizar la acción que desees aquí
            presenter?.getEpisodes()
        }
    }
}

extension EpisodesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // Aquí puedes realizar alguna acción con el término de búsqueda, como buscar en una base de datos o realizar alguna otra tarea relacionada.
            presenter?.searchBarSearchButtonClicked(searchText: searchText)
        }
        searchBar.resignFirstResponder() // Oculta el teclado
    }
}
