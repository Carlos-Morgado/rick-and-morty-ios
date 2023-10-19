//
//  RemoteCharacterDataSource.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import Foundation

enum CharacterDataSourceError: Error {
    case invalidUrl
}

protocol CharacterDataSource {
    // Interactor -> DataSource
    func getCharacters(isNewSearch: Bool, name: String?, successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
    func getCharacterDetail(urlString: String, successCompletionDataSource: @escaping (CharacterDTO) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
}


extension CharacterDataSource {
    
    func getCharacters(isNewSearch: Bool = false, name: String? = nil, successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        getCharacters(isNewSearch: isNewSearch, name: name, successCompletionDataSource: successCompletionDataSource, errorCompletionDataSource: errorCompletionDataSource)
    }
    
}

final class DefaultCharacterDataSource {
    private let networkManager: NetworkManager
    private var paginationInfo: AllCharactersDTO.Info?
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultCharacterDataSource: CharacterDataSource {
    func getCharacters(isNewSearch: Bool = false, name: String? = nil, successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        if isNewSearch {
            paginationInfo = nil
        }
        var url: URL?
        var parameters: [NetworkParameter] = []
        if let name, !name.isEmpty {
            paginationInfo = nil
            parameters.append(NetworkParameter(query: "name", value: name))
            url = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .character, parameters: parameters).url
        } else {
            if let paginationInfo {
                // We have pagination info
                guard let nextUrl = paginationInfo.next else {
                    // Next page doesn't exists, because is the last, we no longer have to ask for more info
                    return
                }
                url = URL(string: nextUrl)
            } else {
                paginationInfo = nil
                url = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .character).url
            }
        }
        
        guard let url else {
            fatalError("Invalid URL")
        }
        
        networkManager.request(url: url, httpMethod: .get) { [weak self] result in
            let dto = result as AllCharactersDTO
            self?.paginationInfo = dto.info
            successCompletionDataSource(dto.results)
        } errorCompletionNetworkManager: { error in
            errorCompletionDataSource(error)
        }
        
    }
    
    func getCharacterDetail(urlString: String, successCompletionDataSource: @escaping (CharacterDTO) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        guard let characterDetailURL = URL(string: urlString) else {
            errorCompletionDataSource(CharacterDataSourceError.invalidUrl)
            return
        }
        
        networkManager.request(url: characterDetailURL, httpMethod: .get) { result in
            let dto = result as CharacterDTO
            successCompletionDataSource(dto)
        } errorCompletionNetworkManager: { error in
            errorCompletionDataSource(error)
        }
    }
}
