//
//  Restaurant.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/29/21.
//

import CoreLocation
import UIKit
import MapKit

class Restaurant: NSObject, MKAnnotation {
    
    var name: String?
    var coordinate: CLLocationCoordinate2D
    var rating: Int?
    var priceLevel: Int?
    var userRatingTotal: Int?
    var detailText: String?
    var placeId: String?
    
    init(name: String, coordinate: CLLocationCoordinate2D, rating: Int?, priceLevel: Int?, userRatingTotal: Int?, detailText: String, placeId: String?) {
        self.name = name
        self.coordinate = coordinate
        self.rating = rating
        self.priceLevel = priceLevel
        self.userRatingTotal = userRatingTotal
        self.detailText = detailText
        self.placeId = placeId
    }

    
    public func getRatingImage(rating: Int) -> UIImage? {
        switch rating {
        case 1:
            return UIImage(named: "oneStars")
        case 2:
            return UIImage(named: "twoStars")
        case 3:
            return UIImage(named: "threeStars")
        case 4:
            return UIImage(named: "fourStars")
        case 5:
            return UIImage(named: "fiveStars")
        default:
            return UIImage(named: "zeroStars")
        }
    }
    
    public func getDollarSigns(priceLevel: Int) -> String {
        switch priceLevel {
        case 0:
            return "Free"
        case 1:
            return "$"
        case 2:
            return "$$"
        case 3:
            return "$$$"
        case 4:
            return "$$$$"
        default:
            return Constants.notAvailableText
        }
    }
    
    public func getUserRatingTotalText(userRatingTotal: Int) -> String {
        return "(\(userRatingTotal))"
    }
    
    public func isFavorite(placeId: String) -> Bool {
        //TODO: ADD USERDEFULT FUNC
        return false
    }
}