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
    func didSelectRowAt(_ indexPath: IndexPath)
    func getCharacters()
    func searchBarSearchButtonClicked(searchText: String)
}

final class DefaultCharactersPresenter {
    
    var characters: [CharacterDTO] = []
    
    private weak var viewController: CharactersView?
    private let router: CharactersRouter
    private let getCharactersInteractor: GetCharactersInteractorInput
    private var isGettingCharacters: Bool = false
    
    init(router: CharactersRouter, viewController: CharactersView, getCharactersInteractor: GetCharactersInteractorInput) {
        self.router = router
        self.viewController = viewController
        self.getCharactersInteractor = getCharactersInteractor
    }
}


// MARK: - EXTENSIONS

extension DefaultCharactersPresenter: CharactersPresenter {
    
    func viewDidLoad() {
        getCharacters()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let character = characters[indexPath.row]
        router.navigateToCharacterDetail(character)
    }
    
    func getCharacters() {
        if !isGettingCharacters {
            isGettingCharacters = true
            getCharactersInteractor.getCharacters()
        }
    }
    
    func searchBarSearchButtonClicked(searchText: String) {
        characters = []
        viewController?.reloadCharacters()
        getCharactersInteractor.getCharacters(isNewSearch: true, name: searchText)
    }
}

extension DefaultCharactersPresenter: GetCharactersInteractorOutput {
    func manageGetCharactersSuccess(characters: [CharacterDTO]) {
        self.characters.append(contentsOf: characters)
        viewController?.reloadCharacters()
        isGettingCharacters = false
    }
    
    func manageGetCharactersError() {
        router.showNetworkErrorAlert()
        isGettingCharacters = false
    }
}
