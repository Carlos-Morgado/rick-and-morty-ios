//
//  AllCharactersDTO.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 23/8/23.
//

import Foundation

struct AllCharactersDTO: Decodable {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [CharacterDTO]
}
