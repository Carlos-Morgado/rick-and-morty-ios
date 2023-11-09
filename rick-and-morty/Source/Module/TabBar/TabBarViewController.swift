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
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor.mainBackgroundColor1

        tabAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.mainGreen1
        tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.mainGreen1]

        tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.mainBlue1
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.mainBlue1]

        UITabBar.appearance().standardAppearance = tabAppearance

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .mainBackgroundColor1
        appearance.titleTextAttributes = [.foregroundColor: UIColor.mainGreen1]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let charactersViewControllerNavigation = UINavigationController(rootViewController: DefaultCharactersRouter.create())
        charactersViewControllerNavigation.tabBarItem = UITabBarItem(title: ("characters_screen_navigation_title".localized), image: UIImage(systemName: "person"), tag: 1)
        let episodesViewControllerNavigation = UINavigationController(rootViewController: DefaultEpisodesRouter.create())
        episodesViewControllerNavigation.tabBarItem = UITabBarItem(title: ("episodes_screen_navigation_title".localized), image: UIImage(systemName: "tv"), tag: 2)
        let locationsViewControllerNavigation = UINavigationController(rootViewController: DefaultLocationsRouter.create())
        locationsViewControllerNavigation.tabBarItem = UITabBarItem(title: ("locations_screen_navigation_title".localized), image: UIImage(systemName: "globe"), tag: 3)
        
        
        setViewControllers([charactersViewControllerNavigation, episodesViewControllerNavigation, locationsViewControllerNavigation], animated: true)
    }

}
