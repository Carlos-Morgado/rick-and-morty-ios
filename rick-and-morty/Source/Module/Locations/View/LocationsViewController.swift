//
//  LocationsViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

protocol LocationsView: AnyObject {
    // Presenter -> View
    func showLocationsList()
}


final class LocationsViewController: UIViewController {

    var presenter: LocationsPresenter?
    
    private lazy var locationsTableView: UITableView = {
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

// MARK: - CONFIG VIEW

extension LocationsViewController: LocationsView {
    
    func showLocationsList() {
        locationsTableView.reloadData()
    }
}

private extension LocationsViewController {
    
    func configView() {
        title = "locations_screen_navigation_title".localized
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor1
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .mainBackgroundColor1
        
        view.addSubview(locationsTableView)
        configLocationsTableView()
        NSLayoutConstraint.activate([
            locationsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            locationsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            locationsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            locationsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configLocationsTableView() {
        locationsTableView.dataSource = self
        locationsTableView.delegate = self
        locationsTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
        locationsTableView.isScrollEnabled = true
        locationsTableView.backgroundColor = .clear
        locationsTableView.layer.cornerRadius = 0
    }
}

// MARK: - EXTENSIONS

extension LocationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.locations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = locationsTableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier) as? LocationTableViewCell, let location = presenter?.locations[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellLabelTexts(setLocationName: location.name, setLocationType: location.type)
        return cell
    }
    
    
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
}
