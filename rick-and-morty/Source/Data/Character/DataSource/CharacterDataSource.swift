//
//  RemoteCharacterDataSource.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import Foundation

protocol CharacterDataSource {
    // Interactor -> DataSource
    func getCharacters(successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
}

struct DefaultCharacterDataSource {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultCharacterDataSource: CharacterDataSource {
    
    func getCharacters(successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        guard let charactersURL = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .character).url else {
            fatalError("Invalid URL")
        }
        
        networkManager.request(url: charactersURL, httpMethod: .get) { result in
            let dto = result as AllCharactersDTO
            successCompletionDataSource(dto.results)
        } errorCompletionNetworkManager: { error in
            errorCompletionDataSource(error)
        }
        
    }
}
