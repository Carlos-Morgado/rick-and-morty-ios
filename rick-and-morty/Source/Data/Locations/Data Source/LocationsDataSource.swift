//
//  LocationsDataSource.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation

protocol LocationsDataSource {
    // Interactor -> DataSource
    func getLocations(isNewSearch: Bool, name: String?, successCompletionDataSource: @escaping ([LocationDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void)
}

extension LocationsDataSource {
    func getLocations(isNewSearch: Bool, name: String?, successCompletionDataSource: @escaping ([LocationDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        getLocations(isNewSearch: isNewSearch, name: name, successCompletionDataSource: successCompletionDataSource, errorCompletionDataSource: errorCompletionDataSource)
    }
}

final class DefaultLocationsDataSource {
    private let networkManager: NetworkManager
    private var paginationInfo: AllLocationsDTO.Info?
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

extension DefaultLocationsDataSource: LocationsDataSource {
    
    func getLocations(isNewSearch: Bool = false, name: String? = nil, successCompletionDataSource: @escaping ([LocationDTO]) -> Void, errorCompletionDataSource: @escaping (Error) -> Void) {
        if isNewSearch {
            paginationInfo = nil
        }
        var url: URL?
        var parameters: [NetworkParameter] = []
        
        if let name, !name.isEmpty {
            paginationInfo = nil
            parameters.append(NetworkParameter(query: "name", value: name))
            url = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .location, parameters: parameters).url
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
                url = NetworkURL(baseUrl: Constant.baseUrl, endpoint: .location).url
            }
        }
        
        guard let url else {
            fatalError("Invalid URL")
        }
        
        networkManager.request(url: url, httpMethod: .get) { result in
            let dto = result as AllLocationsDTO
            self.paginationInfo = dto.info
            successCompletionDataSource(dto.results)
        } errorCompletionNetworkManager: { error in
            errorCompletionDataSource(error)
        }
        
    }
}
