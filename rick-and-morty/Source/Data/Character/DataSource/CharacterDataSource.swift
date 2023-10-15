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

final class DefaultCharacterDataSource {
    private let networkManager: NetworkManager
    private var paginationInfo: AllCharactersDTO.Info?
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultCharacterDataSource: CharacterDataSource {
    
    func getCharacters(successCompletionDataSource: @escaping ([CharacterDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        var url: URL?
        if let paginationInfo {
            // Tenemos información de la paginación
            guard let nextUrl = paginationInfo.next else {
                // No existe siguiente página, porque ya es la última, ya no tenemos que pedir más info
                return
            }
            url = URL(string: nextUrl)
        } else {
           // Es la primera petición , no tenemos info de la paginación,
            url = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .character).url
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
}
