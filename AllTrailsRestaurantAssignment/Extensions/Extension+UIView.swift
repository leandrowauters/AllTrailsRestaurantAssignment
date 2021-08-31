//
//  Extension+UIView.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/31/21.
//

import UIKit

extension UIView {
    func setAsSearchView() {
        backgroundColor = Constants.primaryColor
        layer.cornerRadius = Constants.cornernRadius
        clipsToBounds = true
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor
    }
}
