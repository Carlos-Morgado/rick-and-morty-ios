//
//  EpisodesRouter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/9/23.
//

import Foundation
import UIKit

protocol EpisodesRouter {
    var viewController: UIViewController? { get set }
    
}

final class DefaultEpisodesRouter {
    weak var viewController: UIViewController?
    
    static func create() -> UIViewController {
        var router: EpisodesRouter = DefaultEpisodesRouter()
        let viewController = EpisodesViewController()
        var getEpisodesInteractor: GetEpisodesInteractorInput = DefaultGetEpisodesInteractor()
        let presenter = DefaultEpisodesPresenter(router: router, viewController: viewController, getEpisodesInteractor: getEpisodesInteractor)

        viewController.presenter = presenter
        router.viewController = viewController
        getEpisodesInteractor.presenter = presenter

        return viewController
    }
    
}

// MARK: - EXTENSIONS

extension DefaultEpisodesRouter: EpisodesRouter {

    
}
