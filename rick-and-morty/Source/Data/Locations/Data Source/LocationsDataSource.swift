//
//  LocationsDataSource.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation

protocol LocationsDataSource {
    // Interactor -> DataSource
    func getLocations(successCompletionDataSource: @escaping ([LocationDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
}

struct DefaultLocationsDataSource {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultLocationsDataSource: LocationsDataSource {
    
    func getLocations(successCompletionDataSource: @escaping ([LocationDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        guard let locationsURL = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .location).url else {
            fatalError("Invalid URL")
        }
        
        networkManager.request(url: locationsURL, httpMethod: .get) { result in
            let dto = result as AllLocationsDTO
            successCompletionDataSource(dto.results)
        } errorCompletionNetworkManager: { error in
            errorCompletionDataSource(error)
        }
        
    }
}
