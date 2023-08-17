//
//  UIView + AddSubViews.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 15/8/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
