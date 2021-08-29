//
//  mapView.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/29/21.
//

import UIKit
import MapKit

class MapView: MKMapView {
    
    public func setupUI(contentView: UIView) {
        contentView.addSubview(self)
        contentView.sendSubviewToBack(self)
        self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            self.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            self.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }
    
}
