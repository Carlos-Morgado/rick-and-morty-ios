//
//  EpisodesViewController.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import UIKit

class EpisodesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "episodes_screen_navigation_title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}
