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
    
    @IBAction func didPressFavoriteButton(_ sender: UIButton) {
        print("FAVORITE PRESSED\(sender.tag)")
        restaurantCellDelegate?.didPressFavorite(tag: sender.tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
