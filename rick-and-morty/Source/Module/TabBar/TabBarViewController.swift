//
//  TabBarViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }

    private func setUpTabs() {
        let charactersViewController = CharactersViewController()
        charactersViewController.navigationItem.largeTitleDisplayMode = .automatic
        let episodesViewController = EpisodesViewController()
        episodesViewController.navigationItem.largeTitleDisplayMode = .automatic
        let locationsViewController = LocationsViewController()
        locationsViewController.navigationItem.largeTitleDisplayMode = .automatic
        
        let charactersViewControllerNavigation = UINavigationController(rootViewController: charactersViewController)
        charactersViewControllerNavigation.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        let episodesViewControllerNavigation = UINavigationController(rootViewController: episodesViewController)
        episodesViewControllerNavigation.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 2)
        let locationsViewControllerNavigation = UINavigationController(rootViewController: locationsViewController)
        locationsViewControllerNavigation.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 3)
        
        for navigation in [charactersViewControllerNavigation, episodesViewControllerNavigation, locationsViewControllerNavigation] {
            navigation.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([charactersViewControllerNavigation, episodesViewControllerNavigation, locationsViewControllerNavigation], animated: true)
    }

}
