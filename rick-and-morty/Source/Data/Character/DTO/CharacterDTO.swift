//
//  CharacterDTO.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: CharacterStatusDTO
    let species: String
    let type: String
    let gender: CharacterGenderDTO
    let origin: CharacterOriginDTO
    let location: CharacterLocationDTO
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
