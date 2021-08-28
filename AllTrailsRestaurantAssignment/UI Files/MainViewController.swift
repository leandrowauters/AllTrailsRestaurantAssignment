//
//  MainViewController.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/27/21.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment to test endpoints
//        testEndpoint()
        // Do any additional setup after loading the view.
    }
    
    func testEndpoint() {
        let location = "40.7484,-73.9857"
        let endpoint = NetworkClient.endpoint(searchType: .Text, location: location, textSearch: "bakery")
        print(endpoint ?? "BAD ENDPOINT")
    }


}
