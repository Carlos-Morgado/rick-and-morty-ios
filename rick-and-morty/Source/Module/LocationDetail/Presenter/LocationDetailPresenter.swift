//
//  LocationDetailPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation

protocol LocationDetailPresenter {
    
    var location: LocationDTO { get }
    var residents: [CharacterDTO] { get }
    func getLocationInfoCellValue(infoValue: LocationTypeInfo) -> String
    func viewDidLoad()
}

final class DefaultLocationDetailPresenter {
    
    private let router: LocationDetailRouter
    private weak var viewController: LocationDetailView?
    var location: LocationDTO
    let getCharacterDetailInteractor: GetCharacterDetailInteractorInput
    
    var residents: [CharacterDTO] = []
    
    init(router: LocationDetailRouter, viewController: LocationDetailView, location: LocationDTO, getCharacterDetailInteractor: GetCharacterDetailInteractorInput) {
        self.router = router
        self.viewController = viewController
        self.location = location
        self.getCharacterDetailInteractor = getCharacterDetailInteractor
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
    
    func viewDidLoad() {
        for resident in location.residents {
            getCharacterDetailInteractor.getCharacterDetail(urlString: resident)
        }
    }
}

extension DefaultLocationDetailPresenter: GetCharacterDetailInteractorOutput {
    func manageGetCharacterDetailSuccess(characterDetail: CharacterDTO) {
        residents.append(characterDetail)
        residents.sort {$0.id < $1.id}
        viewController?.reloadData()
    }
    
    func manageGetCharacterDetailError() {
        // TODO: Manage error
    }
}
