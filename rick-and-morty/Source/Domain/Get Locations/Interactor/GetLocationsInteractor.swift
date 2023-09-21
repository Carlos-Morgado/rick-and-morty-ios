//
//  LocationsInteractor.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation

protocol GetLocationsInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func manageGetLocationsSuccess(locations: [LocationDTO])
    func manageGetLocationsError()
}

protocol GetLocationsInteractorInput {
    // Presenter -> Interactor
    var presenter: GetLocationsInteractorOutput? { get set } // Reading and writting variables
    func getLocations()
}

final class DefaultGetLocationsInteractor {
    weak var presenter: GetLocationsInteractorOutput?
    private let locationsDataSource: LocationsDataSource
    init(locationsDataSource: LocationsDataSource = DefaultLocationsDataSource()) {
        self.locationsDataSource = locationsDataSource
    }
}

// MARK: - EXTENSIONS

extension DefaultGetLocationsInteractor: GetLocationsInteractorInput {
    func getLocations() {
        locationsDataSource.getLocations(successCompletionDataSource: { [weak self] locations in // DataSource successCompletion variable name
           self?.presenter?.manageGetLocationsSuccess(locations: locations)
        }, errorCompletionDataSource: { [weak self] _ in
            self?.presenter?.manageGetLocationsError()
        })
    }
}

