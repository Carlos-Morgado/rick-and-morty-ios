//
//  CharacterPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import Foundation

protocol CharactersPresenter {
    // View -> Presenter
    var characters: [CharacterDTO] { get }
    func viewDidLoad()
    
}

final class DefaultCharactersPresenter {
    
    var characters: [CharacterDTO] = []
    
    private weak var viewController: CharactersView?
    private let router: CharactersRouter
    private let getCharactersInteractor: GetCharactersInteractorInput
    
    init(router: CharactersRouter, viewController: CharactersView, getCharactersInteractor: GetCharactersInteractorInput) {
        self.router = router
        self.viewController = viewController
        self.getCharactersInteractor = getCharactersInteractor
    }
}


// MARK: - EXTENSIONS

extension DefaultCharactersPresenter: CharactersPresenter {
    
    func viewDidLoad() {
        getCharactersInteractor.getCharacters()
    }
    
}

extension DefaultCharactersPresenter: GetCharactersInteractorOutput {
    func manageGetCharactersSuccess(characters: [CharacterDTO]) {
        self.characters = characters
        viewController?.showCharactersList()
    }
    
    func manageGetCharactersError() {
        router.showNetworkErrorAlert()
    }
    
    
}
