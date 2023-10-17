//
//  GetcharacterDetailInteractor.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 16/10/23.
//

import Foundation

protocol GetCharacterDetailInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func manageGetCharacterDetailSuccess(characterDetail: CharacterDTO)
    func manageGetCharacterDetailError()
}

protocol GetCharacterDetailInteractorInput {
    // Presenter -> Interactor
    var presenter: GetCharacterDetailInteractorOutput? { get set } // Reading and writting variables
    func getCharacterDetail(urlString: String)
}

final class DefaultGetCharacterDetailInteractor {
    weak var presenter: GetCharacterDetailInteractorOutput?
    private let charactersDataSource: CharacterDataSource
    init(charactersDataSource: CharacterDataSource = DefaultCharacterDataSource()) {
        self.charactersDataSource = charactersDataSource
    }
}

// MARK: - EXTENSIONS

extension DefaultGetCharacterDetailInteractor: GetCharacterDetailInteractorInput {
    func getCharacterDetail(urlString: String) {
        charactersDataSource.getCharacterDetail(urlString: urlString) { [weak self] character in
            self?.presenter?.manageGetCharacterDetailSuccess(characterDetail: character)
        } errorCompletionDataSource: { [weak self] _ in
            self?.presenter?.manageGetCharacterDetailError()
        }

    }
}
