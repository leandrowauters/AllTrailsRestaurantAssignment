//
//  ListTableView.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/28/21.
//

import UIKit

class ListTableView: UITableView {

    
    
    public func setupUI(contentView: UIView) {
        contentView.addSubview(self)
        contentView.sendSubviewToBack(self)
        backgroundColor = Constants.secondaryColor
        separatorStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            self.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            self.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }

}
