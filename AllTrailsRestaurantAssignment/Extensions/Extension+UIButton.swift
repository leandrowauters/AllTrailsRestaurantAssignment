//
//  Extension+UIButton.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/31/21.
//

import Foundation
import UIKit

extension UIButton {

    
    func setAsContentButton() {
        layer.cornerRadius = Constants.cornernRadius
        clipsToBounds = true
        tintColor = .white
        backgroundColor = Constants.tertiaryColor
        layer.borderColor = Constants.borderColor
        layer.borderWidth = Constants.borderWidth
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        imageEdgeInsets = UIEdgeInsets(top: Constants.imageInsets, left: Constants.imageInsets, bottom: Constants.imageInsets, right: Constants.imageInsets)
        titleEdgeInsets = UIEdgeInsets(top: Constants.imageInsets, left: Constants.imageInsets, bottom: Constants.imageInsets, right: -Constants.imageInsets)
    }

    func setAsSearchNearbyButton() {
        setTitle("", for: .normal)
        setImage(Constants.searchNearbyImage, for: .normal)
        layer.cornerRadius = Constants.cornernRadius
        clipsToBounds = true
        tintColor = Constants.tertiaryColor
        backgroundColor = .white
        layer.borderColor = Constants.borderColor
        layer.borderWidth = Constants.borderWidth
    }
}
