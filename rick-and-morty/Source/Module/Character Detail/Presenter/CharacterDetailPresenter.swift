//
//  CharacterDetailPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 6/9/23.
//

import Foundation

protocol CharacterDetailPresenter {
    var character: CharacterDTO { get }
    func getInfoCellValue(infoType: CharacterTypeInfo) -> String
}

final class DefaultCharacterDetailPresenter {
    
    static let apiToDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let dateToStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    private let router: CharacterDetailRouter
    private weak var viewController: CharacterDetailView?
    var character: CharacterDTO
    
    init(router: CharacterDetailRouter, viewController: CharacterDetailView, character: CharacterDTO) {
        self.router = router
        self.viewController = viewController
        self.character = character
    }
}

// MARK: - EXTENSIONS

extension DefaultCharacterDetailPresenter: CharacterDetailPresenter {
    func getInfoCellValue(infoType: CharacterTypeInfo) -> String {
        var value: String = ""
        switch infoType {
        case .status:
            value = character.status.localizedText
        case .gender:
            value = character.gender.localizedText
        case .type:
            value = character.type.isEmpty ? "None" : character.type
        case .species:
            value = character.species
        case .origin:
            value = character.origin.name.capitalized
        case .created:
            if let date = Self.apiToDateFormatter.date(from: character.created) {
                value = Self.dateToStringFormatter.string(from: date)
            }
        case .location:
            value = character.location.name
        case .episodeCount:
            value = String(character.episode.count)
        }
        
        return value
    }
}
