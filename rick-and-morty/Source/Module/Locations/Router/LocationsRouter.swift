//
//  LocationsRouter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation
import UIKit

protocol LocationsRouter {
    var viewController: UIViewController? { get set }
    func navigateToLocationDetail(_ location: LocationDTO)
    func showNetworkErrorAlert()
}

final class DefaultLocationsRouter {
    weak var viewController: UIViewController?
    
    static func create() -> UIViewController {
        var router: LocationsRouter = DefaultLocationsRouter()
        let viewController = LocationsViewController()
        var getLocationsInteractor: GetLocationsInteractorInput = DefaultGetLocationsInteractor()
        let presenter = DefaultLocationsPresenter(router: router, viewController: viewController, getLocationsInteractor: getLocationsInteractor)

        viewController.presenter = presenter
        router.viewController = viewController
        getLocationsInteractor.presenter = presenter

        return viewController
    }
    
}

// MARK: - EXTENSIONS

extension DefaultLocationsRouter: LocationsRouter {
    func navigateToLocationDetail(_ location: LocationDTO) {
        let locationDetailModule = DefaultLocationDetailRouter.create(location: location)
        viewController?.navigationController?.pushViewController(locationDetailModule, animated: true)
    }
    
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
