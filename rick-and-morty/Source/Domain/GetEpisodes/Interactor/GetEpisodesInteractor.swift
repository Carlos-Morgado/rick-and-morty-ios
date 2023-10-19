//
//  GetEpisodesInteractor.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/9/23.
//

import Foundation

protocol GetEpisodesInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func manageGetEpisodesSuccess(episodes: [EpisodeDTO])
    func manageGetEpisodesError()
}

protocol GetEpisodesInteractorInput {
    // Presenter -> Interactor
    var presenter: GetEpisodesInteractorOutput? { get set } // Reading and writting variables
    func getEpisodes(isNewSearch: Bool, name: String?)
}

extension GetEpisodesInteractorInput {
    
    func getEpisodes(isNewSearch: Bool = false, name: String? = nil) {
        getEpisodes(isNewSearch: isNewSearch, name: name)
    }
}

final class DefaultGetEpisodesInteractor {
    weak var presenter: GetEpisodesInteractorOutput?
    private let episodesDataSource: EpisodesDataSource
    init(episodesDataSource: EpisodesDataSource = DefaultEpisodesDataSource()) {
        self.episodesDataSource = episodesDataSource
    }
}

// MARK: - EXTENSIONS

extension DefaultGetEpisodesInteractor: GetEpisodesInteractorInput {
    func getEpisodes(isNewSearch: Bool = false, name: String? = nil) {
        episodesDataSource.getEpisodes(isNewSearch: isNewSearch, name: name, successCompletionDataSource: { [weak self] episodes in // DataSource successCompletion variable name
           self?.presenter?.manageGetEpisodesSuccess(episodes: episodes)
        }, errorCompletionDataSource: { [weak self] _ in
            self?.presenter?.manageGetEpisodesError()
        })
    }
}
