//
//  CharacterRouter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import Foundation
import UIKit

protocol CharactersRouter {
    var viewController: UIViewController? { get set }
    
    func showNetworkErrorAlert()
}

final class DefaultCharactersRouter {
    weak var viewController: UIViewController?
    
    static func create() -> UIViewController {
        var router: CharactersRouter = DefaultCharactersRouter()
        let viewController = CharactersViewController()
        var getCharactersInteractor: GetCharactersInteractorInput = DefaultGetCharactersInteractor()
        let presenter = DefaultCharactersPresenter(router: router, viewController: viewController, getCharactersInteractor: getCharactersInteractor)

        viewController.presenter = presenter
        router.viewController = viewController
        getCharactersInteractor.presenter = presenter

        return viewController
    }
    
}


// MARK: - EXTENSIONS

extension DefaultCharactersRouter: CharactersRouter {
    func showNetworkErrorAlert() {
        let alert = UIAlertController(title: "characters_network_error_alert_title".localized, message: "characters_network_error_alert_message".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "characters_network_error_alert_button".localized, style: .default, handler: { action in
            switch action.style{
            case .default:
                // TODO: Manage error alert action
                break 
            default:
                break
            }
        }))
        viewController?.present(alert, animated: true)
    }
}
