//
//  CharacterStatusDTO.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/8/23.
//

import Foundation

enum CharacterStatusDTO: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var fixedText: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
