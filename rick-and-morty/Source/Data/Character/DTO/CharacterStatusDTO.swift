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
    
    var localizedText: String {
        switch self {
        case .alive:
            return "character-status-alive-value-info".localized
        case .dead:
            return "character-status-dead-value-info".localized
        case .unknown:
            return "character-status-unknown-value-info".localized
        }
    }
}
