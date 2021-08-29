//
//  Extension+UIViewController.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/29/21.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)

        alertController.addAction(okAction)
        alertController.addAction(cancel)
        
      present(alertController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
