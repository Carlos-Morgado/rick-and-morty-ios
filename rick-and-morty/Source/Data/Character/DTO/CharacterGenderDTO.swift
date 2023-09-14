//
//  CharacterGenderDTO.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/8/23.
//

import Foundation

enum CharacterGenderDTO: String, Decodable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    var fixedText: String {
        switch self {
        case .unknown:
            return "Unknown"
        default:
            return rawValue
        }
        
    }
}
