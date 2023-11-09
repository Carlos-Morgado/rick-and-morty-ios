//
//  CharacterTypeInfo.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 13/9/23.
//

import Foundation

enum CharacterTypeInfo: CaseIterable {
    case status
    case gender
    case type
    case species
    case origin
    case created
    case location
    case episodeCount
    
    var localizedText: String {
        switch self {
        case .status:
            return "character-status-type-info".localized
        case .gender:
            return "character-gender-type-info".localized
        case .type:
            return "character-type-type-info".localized
        case .species:
            return "character-species-type-info".localized
        case .origin:
            return "character-origin-type-info".localized
        case .created:
            return "character-created-type-info".localized
        case .location:
            return "character-location-type-info".localized
        case .episodeCount:
            return "character-episode-count-type-info".localized
        }
    }
}
