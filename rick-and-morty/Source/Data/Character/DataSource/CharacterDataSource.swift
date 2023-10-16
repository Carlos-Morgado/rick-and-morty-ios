//
//  RemoteCharacterDataSource.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import Foundation

protocol CharacterDataSource {
    // Interactor -> DataSource
    func getCharacters(name: String?, successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
}

extension CharacterDataSource {
    
    func getCharacters(name: String? = nil, successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        getCharacters(name: name, successCompletionDataSource: successCompletionDataSource, errorCompletionDataSource: errorCompletionDataSource)
    }
    
}

struct DefaultCharacterDataSource {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultCharacterDataSource: CharacterDataSource {
    
    func getCharacters(name: String? = nil, successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        var parameters: [NetworkParameter] = []
        if let name, !name.isEmpty {
            parameters.append(NetworkParameter(query: "name", value: name))
        }
        guard let charactersURL = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .character, parameters: parameters).url else {
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
