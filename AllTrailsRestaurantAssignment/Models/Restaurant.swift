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
    
    static let restaurantImage = UIImage(named: "placeholder")
    
    init(name: String, coordinate: CLLocationCoordinate2D, rating: Int?, priceLevel: Int?, userRatingTotal: Int?, detailText: String, placeId: String?) {
        self.name = name
        self.coordinate = coordinate
        self.rating = rating
        self.priceLevel = priceLevel
        self.userRatingTotal = userRatingTotal
        self.detailText = detailText
        self.placeId = placeId
    }

    
    public func getRatingImage() -> UIImage? {
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
    
    private func getDollarSigns() -> String {
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
    
    public func getDetailText() -> String {
        return "\(getDollarSigns()) - \(detailText ?? Constants.notAvailableText)"
    }
    public func getUserRatingTotalText() -> String {
        return "(\(userRatingTotal ?? 0))"
    }
    
    public func favoriteImage() -> UIImage? {
        
        guard let placeId = placeId else {
            return Constants.notFavoriteImage
        }
        
        let isFavorite = UserDefaultsHelper.defaults.bool(forKey: placeId)
        if isFavorite {
            return Constants.isfavoriteImage
        } else {
            return Constants.notFavoriteImage
        }
        
    }
    
    public func setFavorite() {
        guard let placeId = placeId else {
            return
        }
        if UserDefaultsHelper.defaults.bool(forKey: placeId) {
            UserDefaultsHelper.defaults.removeObject(forKey: placeId)
        } else {
            UserDefaultsHelper.defaults.set(true, forKey: placeId)
        }

    }
    static func getRestuarants(places: [ResultWrapper]) -> [Restaurant] {
        var restaurants = [Restaurant]()
        
        for place in places {
            let name = place.name ?? Constants.notAvailableText
            let location = place.geometry?.location
            let rating = Int(place.rating ?? 0.0)
            let priceLevel = place.priceLevel
            let userRatingTotal = place.userRatingsTotal ?? 0
            let detailText = (place.vicinity ?? place.formattedAddress) ?? Constants.notAvailableText
            let placeId = place.placeID
            let restaurant = Restaurant(name: name, coordinate: CLLocationCoordinate2D(latitude: location?.lat ?? Constants.defultCoordinate.latitude, longitude: location?.lng ?? Constants.defultCoordinate.longitude), rating: rating, priceLevel: priceLevel, userRatingTotal: userRatingTotal, detailText: detailText, placeId: placeId)
            restaurants.append(restaurant)
        }
        
        return restaurants
    }
    
}
