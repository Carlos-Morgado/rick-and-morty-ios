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
    
    var url: URL? {
        URL(string: baseUrl + "/" + endpoint.rawValue)
    }
    
    init(baseUrl: String, endpoint: NetworkEndpoint) {
        self.baseUrl = baseUrl
        self.endpoint = endpoint
    }
}
