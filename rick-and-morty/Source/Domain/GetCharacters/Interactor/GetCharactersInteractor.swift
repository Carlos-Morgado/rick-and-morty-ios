//
//  GetCharactersInteractor.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import Foundation

protocol GetCharactersInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func manageGetCharactersSuccess(characters: [CharacterDTO])
    func manageGetCharactersError()
}

protocol GetCharactersInteractorInput {
    // Presenter -> Interactor
    var presenter: GetCharactersInteractorOutput? { get set } // Variables de lectura y escritura
    func getCharacters()
}

final class DefaultGetCharactersInteractor {
    weak var presenter: GetCharactersInteractorOutput?
    private let characterDataSource: CharacterDataSource
    init(characterDataSource: CharacterDataSource = DefaultCharacterDataSource()) {
        self.characterDataSource = characterDataSource
    }
}



// MARK: - EXTENSIONS

extension DefaultGetCharactersInteractor: GetCharactersInteractorInput {
    func getCharacters() {
        characterDataSource.getCharacters(successCompletionDataSource: { [weak self] characters in // Nombre de la variable del successCompletion del DataSource
           self?.presenter?.manageGetCharactersSuccess(characters: characters)
        }, errorCompletionDataSource: { [weak self] _ in
            self?.presenter?.manageGetCharactersError()
        })
    }
}
