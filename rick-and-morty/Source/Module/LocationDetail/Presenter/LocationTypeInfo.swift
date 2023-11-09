//
//  locationTypeInfo.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 21/9/23.
//

import Foundation

enum LocationTypeInfo: CaseIterable {
    case name
    case type
    case dimension
    
    var localizedText: String {
        switch self {
        case .name:
            return "location_name_type_info".localized
        case .type:
            return "location_type_type_info".localized
        case .dimension:
            return "location_dimension_type_info".localized
        
        }
    }
}
