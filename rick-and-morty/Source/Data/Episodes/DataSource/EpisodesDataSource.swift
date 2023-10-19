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
    func getEpisodes(isNewSearch: Bool, name: String?, successCompletionDataSource: @escaping ([EpisodeDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
    func getEpisodeDetail(urlString: String, successCompletionDataSource: @escaping (EpisodeDTO) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
}

extension EpisodesDataSource {
    func getEpisodes(isNewSearch: Bool = false, name: String? = nil, successCompletionDataSource: @escaping ([EpisodeDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        getEpisodes(isNewSearch: isNewSearch, name: name, successCompletionDataSource: successCompletionDataSource, errorCompletionDataSource: errorCompletionDataSource)
    }
}

final class DefaultEpisodesDataSource {
    private let networkManager: NetworkManager
    private var paginationInfo: AllEpisodesDTO.Info?
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultEpisodesDataSource: EpisodesDataSource {
    func getEpisodes(isNewSearch: Bool = false, name: String? = nil, successCompletionDataSource: @escaping ([EpisodeDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        if isNewSearch {
            paginationInfo = nil
        }
        
        var url: URL?
        var parameters: [NetworkParameter] = []
        
        if let name, !name.isEmpty {
            paginationInfo = nil
            parameters.append(NetworkParameter(query: "name", value: name))
            url = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .episode, parameters: parameters).url
        } else {
            if let paginationInfo {
                // Tenemos información de la paginación
                guard let nextUrl = paginationInfo.next else {
                    // No existe siguiente página, porque ya es la última, ya no tenemos que pedir más info
                    return
                }
                url = URL(string: nextUrl)
            } else {
                paginationInfo = nil
                url = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .episode).url
            }
        }
        
        guard let url else {
            fatalError("Invalid URL")
        }
        
        networkManager.request(url: url, httpMethod: .get) { result in
            let dto = result as AllEpisodesDTO
            self.paginationInfo = dto.info
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
