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
        restaurantRatingImage.image = restaurant.getRatingImage()
        userRatingTotalLabel.text = restaurant.getUserRatingTotalText()
        restaurantAddressLabel.text = restaurant.getDetailText()
    }
    

    private func setupTextLabel() {
        restaurantName.setTitleText()
        userRatingTotalLabel.setDetailText()
        restaurantAddressLabel.setDetailText()
    }
    func setupUI(width: CGFloat, height: CGFloat) {
        setupTextLabel()
        backgroundColor = Constants.primaryColor
//        setupLabel(labels: [restaurantName, restaurantAddressLabel])
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    

}
