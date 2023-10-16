//
//  NetworkURL.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/8/23.
//

import Foundation

struct NetworkURL {
    private var baseUrl: String
    private var endpoint: NetworkEndpoint
    private var parameters: [NetworkParameter]
    
    var url: URL? {
        var urlString = baseUrl + "/" + endpoint.rawValue
        if !parameters.isEmpty {
            urlString += "/?"
            for (index, parameter) in parameters.enumerated() {
                if index != 0 {
                    urlString += "&"
                }
                urlString += parameter.query
                urlString += "="
                urlString += parameter.value
            }
        }
        
        return URL(string: urlString)
    }
    
    init(baseUrl: String, endpoint: NetworkEndpoint, parameters: [NetworkParameter] = []) {
        self.baseUrl = baseUrl
        self.endpoint = endpoint
        self.parameters = parameters
    }
}
