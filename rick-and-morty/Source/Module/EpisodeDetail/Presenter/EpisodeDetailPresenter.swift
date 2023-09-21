//
//  EpisodeDetailPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 19/9/23.
//

import Foundation

protocol EpisodeDetailPresenter {
    var episode: EpisodeDTO { get }
    func getEpisodeInfoCellValue(infoType: EpisodeTypeInfo) -> String
}

final class DefaultEpisodeDetailPresenter {
    
    private let router: EpisodeDetailRouter
    private weak var viewController: EpisodeDetailView?
    var episode: EpisodeDTO
    
    init(router: EpisodeDetailRouter, viewController: EpisodeDetailView, episode: EpisodeDTO) {
        self.router = router
        self.viewController = viewController
        self.episode = episode
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
}

