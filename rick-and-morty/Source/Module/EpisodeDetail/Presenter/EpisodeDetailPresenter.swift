//
//  EpisodeDetailPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 19/9/23.
//

import Foundation

protocol EpisodeDetailPresenter {
    var episode: EpisodeDTO { get }
    var characters: [CharacterDTO] { get }
    func getEpisodeInfoCellValue(infoType: EpisodeTypeInfo) -> String
    func viewDidLoad()
}

final class DefaultEpisodeDetailPresenter {
    
    private let router: EpisodeDetailRouter
    private weak var viewController: EpisodeDetailView?
    var episode: EpisodeDTO
    let getCharacterDetailInteractor: GetCharacterDetailInteractorInput
    var characters: [CharacterDTO] = []
    
    init(router: EpisodeDetailRouter, viewController: EpisodeDetailView, episode: EpisodeDTO, getCharacterDetailInteractor: GetCharacterDetailInteractorInput) {
        self.router = router
        self.viewController = viewController
        self.episode = episode
        self.getCharacterDetailInteractor = getCharacterDetailInteractor
    }
}

// MARK: - EXTENSION

extension DefaultEpisodeDetailPresenter: EpisodeDetailPresenter {
   func getEpisodeInfoCellValue(infoType: EpisodeTypeInfo) -> String {
        var value: String = ""
        switch infoType {
        case .name:
            value = episode.name
        case .airDate:
            value = episode.airDate
        case .episode:
            value = episode.episode
        }
        return value
    }
    
    func viewDidLoad() {
        for character in episode.characters {
            getCharacterDetailInteractor.getCharacterDetail(urlString: character)
        }
    }
}

extension DefaultEpisodeDetailPresenter: GetCharacterDetailInteractorOutput {
    func manageGetCharacterDetailSuccess(characterDetail: CharacterDTO) {
        characters.append(characterDetail)
        characters.sort {$0.id < $1.id}
        viewController?.reloadData()
    }
    
    func manageGetCharacterDetailError() {
        // TODO: Manage error
    }
}

