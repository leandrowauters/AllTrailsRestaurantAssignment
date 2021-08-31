//
//  ListTableViewCell.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/29/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var restaurantName: UILabel!

    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantRatingImage: UIImageView!
    
    @IBOutlet weak var userTotalRatingLabel: UILabel!
    
    @IBOutlet weak var restaurantDetailLabel: UILabel!
    
    @IBOutlet weak var isFavoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
