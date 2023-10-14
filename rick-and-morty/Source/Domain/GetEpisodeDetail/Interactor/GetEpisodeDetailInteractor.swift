//
//  GetEpisodeDetailInteractor.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 13/10/23.
//

import Foundation

protocol GetEpisodeDetailInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func manageGetEpisodeDetailSuccess(episodeDetail: EpisodeDTO)
    func manageGetEpisodeDetailError()
}

protocol GetEpisodeDetailInteractorInput {
    // Presenter -> Interactor
    var presenter: GetEpisodeDetailInteractorOutput? { get set } // Reading and writting variables
    func getEpisodeDetail(urlString: String)
}

final class DefaultGetEpisodeDetailInteractor {
    weak var presenter: GetEpisodeDetailInteractorOutput?
    private let episodesDataSource: EpisodesDataSource
    init(episodesDataSource: EpisodesDataSource = DefaultEpisodesDataSource()) {
        self.episodesDataSource = episodesDataSource
    }
}

// MARK: - EXTENSIONS

extension DefaultGetEpisodeDetailInteractor: GetEpisodeDetailInteractorInput {
    func getEpisodeDetail(urlString: String) {
        episodesDataSource.getEpisodeDetail(urlString: urlString) { [weak self] episode in
            self?.presenter?.manageGetEpisodeDetailSuccess(episodeDetail: episode)
        } errorCompletionDataSource: { [weak self] _ in
            self?.presenter?.manageGetEpisodeDetailError()
        }

    }
}
