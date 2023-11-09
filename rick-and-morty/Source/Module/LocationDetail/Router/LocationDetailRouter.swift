//
//  LocationDetailRouter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation
import UIKit

protocol LocationDetailRouter {
    var viewController: UIViewController? { get set }
}

final class DefaultLocationDetailRouter {
    weak var viewController: UIViewController?
    
    static func create(location: LocationDTO) -> UIViewController {
        var router: LocationDetailRouter = DefaultLocationDetailRouter()
        let viewController = LocationDetailViewController()
        var getCharacterDetailInteractor: GetCharacterDetailInteractorInput = DefaultGetCharacterDetailInteractor()
        let presenter = DefaultLocationDetailPresenter(router: router, viewController: viewController, location: location, getCharacterDetailInteractor: getCharacterDetailInteractor)
        
        viewController.presenter = presenter
        router.viewController = viewController
        getCharacterDetailInteractor.presenter = presenter
        
        return viewController
    }
}

// MARK: - EXTENSIONS

extension DefaultLocationDetailRouter: LocationDetailRouter {
    
}
