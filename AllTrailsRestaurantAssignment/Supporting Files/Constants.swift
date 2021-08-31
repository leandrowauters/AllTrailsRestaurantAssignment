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
    
    // COLOR
    static let primaryColor = UIColor.systemBackground
    static let secondaryColor = UIColor.secondarySystemBackground
    static let tertiaryColor = #colorLiteral(red: 0.368627451, green: 0.5333333333, blue: 0.1607843137, alpha: 1)
    //FONT
    static let titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let detailFont = UIFont.systemFont(ofSize: 14, weight: .thin)
    static let titleColor = UIColor.black
    static let detailColor = UIColor.darkGray
    
    static let imageInsets = CGFloat(15)
    static let listImage = UIImage(systemName: "list.bullet")
    static let mapImape = UIImage(systemName: "map")
    static let searchNearbyImage = UIImage(systemName: "location")
    
}
