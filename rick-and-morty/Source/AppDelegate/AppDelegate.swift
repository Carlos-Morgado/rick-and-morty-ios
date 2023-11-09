//
//  AppDelegate.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 28/7/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupView()
        return true
    }
    // We indicate what is the first view of the app
    private func setupView() {
        // We instantiate UIWindow so that it fits the full screen
        window = UIWindow(frame: UIScreen.main.bounds)
        // We instantiate the controller and store it in a constant
        window?.rootViewController = TabBarViewController()
        // We tell window what is the main view controller
        window?.makeKeyAndVisible()

    }
}

