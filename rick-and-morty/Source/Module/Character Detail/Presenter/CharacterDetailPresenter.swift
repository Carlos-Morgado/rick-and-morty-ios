//
//  CharacterDetailPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 6/9/23.
//

import Foundation

protocol CharacterDetailPresenter {
    func viewDidLoad()
}

final class DefaultCharacterDetailPresenter {
    private let router: CharacterDetailRouter
    private weak var viewController: CharacterDetailView?
    private var character: CharacterDTO
    
    init(router: CharacterDetailRouter, viewController: CharacterDetailView, character: CharacterDTO) {
        self.router = router
        self.viewController = viewController
        self.character = character
    }
}

// MARK: - EXTENSIONS

extension DefaultCharacterDetailPresenter: CharacterDetailPresenter {
    func viewDidLoad() {
        viewController?.showCharacterDetail(character)
    }
}
