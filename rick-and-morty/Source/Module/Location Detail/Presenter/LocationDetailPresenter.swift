//
//  LocationDetailPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation

protocol LocationDetailPresenter {
    var location: LocationDTO { get }
    func getLocationInfoCellValue(infoValue: LocationTypeInfo) -> String
}

final class DefaultLocationDetailPresenter {
    
    private let router: LocationDetailRouter
    private weak var viewController: LocationDetailView?
    var location: LocationDTO
    
    init(router: LocationDetailRouter, viewController: LocationDetailView, location: LocationDTO) {
        self.router = router
        self.viewController = viewController
        self.location = location
    }
}

// MARK: - EXTENSION

extension DefaultLocationDetailPresenter: LocationDetailPresenter {
    func getLocationInfoCellValue(infoValue: LocationTypeInfo) -> String {
        var value: String = ""
        switch infoValue {
        case .name:
            value = location.name
        case .type:
            value = location.type
        case .dimension:
            value = location.dimension.capitalized
        }
        return value
    }
}
