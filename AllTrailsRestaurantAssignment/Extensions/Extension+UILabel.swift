//
//  Extension+UILabel.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/31/21.
//

import UIKit

extension UILabel {
    func setTitleText() {
        font = Constants.titleFont
        textColor = Constants.titleColor
    }
    
    func setDetailText() {
        font = Constants.detailFont
        textColor = Constants.detailColor
    }
}
