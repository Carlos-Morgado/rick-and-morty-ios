//
//  EpisodesPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/9/23.
//

import Foundation

protocol EpisodesPresenter {
    // View -> Presenter
    var episodes: [EpisodeDTO] { get }
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
    func getEpisodes()
    func searchBarSearchButtonClicked(searchText: String)
}

final class DefaultEpisodesPresenter {
    
    var episodes: [EpisodeDTO] = []
    
    private weak var viewController: EpisodesView?
    private let router: EpisodesRouter
    private let getEpisodesInteractor: GetEpisodesInteractorInput
    private var isGettingEpisodes: Bool = false
    
    init(router: EpisodesRouter, viewController: EpisodesView, getEpisodesInteractor: GetEpisodesInteractorInput) {
        self.router = router
        self.viewController = viewController
        self.getEpisodesInteractor = getEpisodesInteractor
    }
}


// MARK: - EXTENSIONS

extension DefaultEpisodesPresenter: EpisodesPresenter {
    func viewDidLoad() {
        getEpisodesInteractor.getEpisodes()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        router.navigateToEpisodeDetail(episode)
    }
    
    func getEpisodes() {
        if !isGettingEpisodes {
            isGettingEpisodes = true
            getEpisodesInteractor.getEpisodes()
        }
    }
    
    func searchBarSearchButtonClicked(searchText: String) {
        episodes = []
        viewController?.reloadEpisodes()
        getEpisodesInteractor.getEpisodes(isNewSearch: true, name: searchText)
    }
}

extension DefaultEpisodesPresenter: GetEpisodesInteractorOutput {
    func manageGetEpisodesSuccess(episodes: [EpisodeDTO]) {
        self.episodes.append(contentsOf: episodes)
        viewController?.reloadEpisodes()
        isGettingEpisodes = false
    }
    
    func manageGetEpisodesError() {
        router.showNetworkErrorAlert()
        isGettingEpisodes = false
    }
    
}
