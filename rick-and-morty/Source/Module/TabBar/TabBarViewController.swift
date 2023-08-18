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
        setUpTabs()
    }

    private func setUpTabs() {
        let charactersViewControllerNavigation = UINavigationController(rootViewController: CharactersViewController())
        charactersViewControllerNavigation.tabBarItem = UITabBarItem(title: ("characters_screen_navigation_title".localized), image: UIImage(systemName: "person"), tag: 1)
        let episodesViewControllerNavigation = UINavigationController(rootViewController: EpisodesViewController())
        episodesViewControllerNavigation.tabBarItem = UITabBarItem(title: ("episodes_screen_navigation_title".localized), image: UIImage(systemName: "tv"), tag: 2)
        let locationsViewControllerNavigation = UINavigationController(rootViewController: LocationsViewController())
        locationsViewControllerNavigation.tabBarItem = UITabBarItem(title: ("locations_screen_navigation_title".localized), image: UIImage(systemName: "globe"), tag: 3)
        
        
        setViewControllers([charactersViewControllerNavigation, episodesViewControllerNavigation, locationsViewControllerNavigation], animated: true)
    }

}
