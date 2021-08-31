//
//  ListTableViewCell.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/29/21.
//

import UIKit

protocol RestaurantCellDelegate: AnyObject {
    func didPressFavorite(tag: Int)
}

class ListTableViewCell: UITableViewCell {

    weak var restaurantCellDelegate: RestaurantCellDelegate?
    
    @IBOutlet weak var restaurantName: UILabel!

    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantRatingImage: UIImageView!
    
    @IBOutlet weak var userTotalRatingLabel: UILabel!
    
    @IBOutlet weak var restaurantDetailLabel: UILabel!
    
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    @IBOutlet weak var infoView: UIView!
    @IBAction func didPressFavoriteButton(_ sender: UIButton) {
        print("FAVORITE PRESSED\(sender.tag)")
        restaurantCellDelegate?.didPressFavorite(tag: sender.tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupUI() {
        restaurantName.setTitleText()
        restaurantDetailLabel.setDetailText()
        userTotalRatingLabel.setDetailText()
        infoView.backgroundColor = Constants.primaryColor
        backgroundColor = Constants.secondaryColor
        isFavoriteButton.tintColor = Constants.tertiaryColor
    }
    func configureCell(with restaurant: Restaurant, tag: Int) {
        setupUI()
        restaurantImage.image = Restaurant.restaurantImage
        restaurantName.text = restaurant.name
        restaurantRatingImage.image = restaurant.getRatingImage()
        restaurantDetailLabel.text = restaurant.getDetailText()
        userTotalRatingLabel.text = restaurant.getUserRatingTotalText()
        isFavoriteButton.tag = tag
        isFavoriteButton.setImage(restaurant.favoriteImage(), for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
