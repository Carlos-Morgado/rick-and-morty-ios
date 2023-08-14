//
//  NetworkError.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import Foundation

enum NetworkError: Error {
    
    case requestError(Error)
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidData
    
}
