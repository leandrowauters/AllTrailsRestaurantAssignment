//
//  Constants.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/29/21.
//

import Foundation
import CoreLocation
import UIKit
struct Constants {
    static let regionRadius: Double = 1500
    static let notAvailableText = "N/A"
    static let defultCoordinate = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
    static let selectedPin = UIImage(named: "pinSelected")
    static let unselectedPin = UIImage(named: "pinUnselected")
    static let isfavoriteImage = UIImage(systemName: "heart.fill")
    static let notFavoriteImage = UIImage(systemName: "heart")
}
