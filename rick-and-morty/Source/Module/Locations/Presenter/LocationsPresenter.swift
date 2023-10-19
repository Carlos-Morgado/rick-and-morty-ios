//
//  LocationsPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation

protocol LocationsPresenter {
    // View -> Presenter
    var locations: [LocationDTO] { get }
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
    func getLocations()
    func searchBarSearchButtonClicked(searchText: String)
}

final class DefaultLocationsPresenter {
    
    var locations: [LocationDTO] = []
    
    private weak var viewController: LocationsView?
    private let router: LocationsRouter
    private let getLocationsInteractor: GetLocationsInteractorInput
    
    private var isGettingLocations: Bool = false
    
    init(router: LocationsRouter, viewController: LocationsView, getLocationsInteractor: GetLocationsInteractorInput) {
        self.router = router
        self.viewController = viewController
        self.getLocationsInteractor = getLocationsInteractor
    }
}

// MARK: - EXTENSIONS

extension DefaultLocationsPresenter: LocationsPresenter {
    func viewDidLoad() {
        getLocationsInteractor.getLocations()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let location = locations[indexPath.row]
        router.navigateToLocationDetail(location)
    }
    
    func getLocations() {
        if !isGettingLocations {
            isGettingLocations = true
            getLocationsInteractor.getLocations()
        }
    }
    
    func searchBarSearchButtonClicked(searchText: String) {
        locations = []
        viewController?.reloadLocations()
        getLocationsInteractor.getLocations(isNewSearch: true, name: searchText)
    }
}

extension DefaultLocationsPresenter: GetLocationsInteractorOutput {
    func manageGetLocationsSuccess(locations: [LocationDTO]) {
        self.locations.append(contentsOf: locations)
        viewController?.reloadLocations()
        isGettingLocations = false
    }
    
    func manageGetLocationsError() {
        router.showNetworkErrorAlert()
        isGettingLocations = false
    }
    
}
