//
//  String+Localized.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 18/8/23.
//

import UIKit

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
    
}
