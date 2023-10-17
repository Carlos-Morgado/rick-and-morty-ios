//
//  EpisodeDetailRouter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 19/9/23.
//

import Foundation
import UIKit

protocol EpisodeDetailRouter {
    var viewController: UIViewController? { get set }
}

final class DefaultEpisodeDetailRouter {
    weak var viewController: UIViewController?
    
    static func create(episode: EpisodeDTO) -> UIViewController {
        var router: EpisodeDetailRouter = DefaultEpisodeDetailRouter()
        let viewController = EpisodeDetailViewController()
        var getCharacterDetailInteractor: GetCharacterDetailInteractorInput = DefaultGetCharacterDetailInteractor()
        let presenter = DefaultEpisodeDetailPresenter(router: router, viewController: viewController, episode: episode, getCharacterDetailInteractor: getCharacterDetailInteractor)
        
        viewController.presenter = presenter
        router.viewController = viewController
        getCharacterDetailInteractor.presenter = presenter
        
        return viewController
    }
}

// MARK: - EXTENSIONS

extension DefaultEpisodeDetailRouter: EpisodeDetailRouter {
    
}
