//
//  EpisodesDataSource.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/9/23.
//

import Foundation

enum EpisodeDataSourceError: Error {
    case invalidUrl
}

protocol EpisodesDataSource {
    // Interactor -> DataSource
    func getEpisodes(successCompletionDataSource: @escaping ([EpisodeDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
    func getEpisodeDetail(urlString: String, successCompletionDataSource: @escaping (EpisodeDTO) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
}

struct DefaultEpisodesDataSource {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultEpisodesDataSource: EpisodesDataSource {
    func getEpisodes(successCompletionDataSource: @escaping ([EpisodeDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        guard let episodesURL = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .episode).url else {
            fatalError("Invalid URL")
        }
        
        networkManager.request(url: episodesURL, httpMethod: .get) { result in
            let dto = result as AllEpisodesDTO
            successCompletionDataSource(dto.results)
        } errorCompletionNetworkManager: { error in
            errorCompletionDataSource(error)
        }
        
    }
    
    func getEpisodeDetail(urlString: String, successCompletionDataSource: @escaping (EpisodeDTO) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        guard let episodeDetailURL = URL(string: urlString) else {
            errorCompletionDataSource(EpisodeDataSourceError.invalidUrl)
            return
        }
        
        networkManager.request(url: episodeDetailURL, httpMethod: .get) { result in
            let dto = result as EpisodeDTO
            successCompletionDataSource(dto)
        } errorCompletionNetworkManager: { error in
            errorCompletionDataSource(error)
        }

    }
}
