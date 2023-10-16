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
    var presenter: GetCharactersInteractorOutput? { get set } // Reading and writting variables
    func getCharacters(name: String?)
}

extension GetCharactersInteractorInput {
    
    func getCharacters(name: String? = nil) {
        getCharacters(name: name)
    }
    
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
    func getCharacters(name: String? = nil) {
        characterDataSource.getCharacters(name: name, successCompletionDataSource: { [weak self] characters in // DataSource successCompletion variable name
           self?.presenter?.manageGetCharactersSuccess(characters: characters)
        }, errorCompletionDataSource: { [weak self] _ in
            self?.presenter?.manageGetCharactersError()
        })
    }
}
