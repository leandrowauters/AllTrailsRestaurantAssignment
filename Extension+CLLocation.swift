//
//  Extension+CLLocation.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/27/21.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func urlQueryItemString() -> String {
        let coordinates = "\(latitude),\(longitude)"
        return coordinates
    }
}
