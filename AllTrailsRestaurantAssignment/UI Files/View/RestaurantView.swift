//
//  RestaurantView.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/30/21.
//

import UIKit

class RestaurantView: UIView {

    
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantRatingImage: UIImageView!
    @IBOutlet weak var userRatingTotalLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!

    
    class func instanceFromNib() -> RestaurantView {
        return UINib(nibName: "RestaurantView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RestaurantView
    }
    
    func configure(with restaurant: Restaurant) {
        placeholderImage.image = Restaurant.restaurantImage
        restaurantName.text = restaurant.name
        restaurantRatingImage.image = restaurant.getRatingImage(rating: restaurant.rating ?? 0)
        userRatingTotalLabel.text = restaurant.getUserRatingTotalText(userRatingTotal: restaurant.userRatingTotal ?? 0)
        restaurantAddressLabel.text = restaurant.getDetailText()
    }
    
    func setupLabel(labels: [UILabel]) {
        for label in labels {
            label.sizeToFit()
            label.numberOfLines = 1
            label.lineBreakMode = .byWordWrapping
        }
    }
    
    func setupUI(width: CGFloat, height: CGFloat) {
//        setupLabel(labels: [restaurantName, restaurantAddressLabel])
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    

}
