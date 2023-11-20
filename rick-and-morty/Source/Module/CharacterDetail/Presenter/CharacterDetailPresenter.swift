//
//  CharacterDetailPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 6/9/23.
//

import Foundation

protocol CharacterDetailPresenter {
    var character: CharacterDTO { get }
    var episodes: [EpisodeDTO] { get }
    func getInfoCellValue(infoType: CharacterTypeInfo) -> String
    func viewDidLoad()
}

final class DefaultCharacterDetailPresenter {
    
    static let apiToDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let dateToStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    private let router: CharacterDetailRouter
    private weak var viewController: CharacterDetailView?
    let character: CharacterDTO
    let getEpisodeDetailInteractor: GetEpisodeDetailInteractorInput
    var episodes: [EpisodeDTO] = []
    
    init(router: CharacterDetailRouter, viewController: CharacterDetailView, character: CharacterDTO, getEpisodeDetailInteractor: GetEpisodeDetailInteractorInput) {
        self.router = router
        self.viewController = viewController
        self.character = character
        self.getEpisodeDetailInteractor = getEpisodeDetailInteractor
    }
}

// MARK: - EXTENSIONS

extension DefaultCharacterDetailPresenter: CharacterDetailPresenter {
    
    func getInfoCellValue(infoType: CharacterTypeInfo) -> String {
        var value: String = ""
        switch infoType {
        case .status:
            value = character.status.localizedText
        case .gender:
            value = character.gender.localizedText
        case .type:
            value = character.type.isEmpty ? "None" : character.type
        case .species:
            value = character.species
        case .origin:
            value = character.origin.name.capitalized
        case .created:
            if let date = Self.apiToDateFormatter.date(from: character.created) {
                value = Self.dateToStringFormatter.string(from: date)
            }
        case .location:
            value = character.location.name
        case .episodeCount:
            value = String(character.episode.count)
        }
        
        return value
    }
    
    func viewDidLoad() {
        for episode in character.episode {
            getEpisodeDetailInteractor.getEpisodeDetail(urlString: episode)
        }
        
    }
}

extension DefaultCharacterDetailPresenter: GetEpisodeDetailInteractorOutput {
    func manageGetEpisodeDetailSuccess(episodeDetail: EpisodeDTO) {
        episodes.append(episodeDetail)
        episodes.sort {$0.id < $1.id}
        viewController?.reloadData()
    }
    
    func manageGetEpisodeDetailError() {
        // TODO: Manage error
    }
}
