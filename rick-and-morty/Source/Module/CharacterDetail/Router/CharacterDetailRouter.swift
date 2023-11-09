//
//  CharacterDetailRouter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 6/9/23.
//

import Foundation
import UIKit

protocol CharacterDetailRouter {
    var viewController: UIViewController? { get set }
}

final class DefaultCharacterDetailRouter {
    weak var viewController: UIViewController?
    
    static func create(character: CharacterDTO) -> UIViewController {
        var router: CharacterDetailRouter = DefaultCharacterDetailRouter()
        let viewController = CharacterDetailViewController()
        var getEpisodeDetailInteractor: GetEpisodeDetailInteractorInput = DefaultGetEpisodeDetailInteractor()
        let presenter = DefaultCharacterDetailPresenter(router: router, viewController: viewController, character: character, getEpisodeDetailInteractor: getEpisodeDetailInteractor)
        
        viewController.presenter = presenter
        router.viewController = viewController
        getEpisodeDetailInteractor.presenter = presenter
        
        return viewController
    }
}

// MARK: - EXTENSIONS

extension DefaultCharacterDetailRouter: CharacterDetailRouter {
    
}
