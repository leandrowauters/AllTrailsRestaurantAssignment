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
        NetworkClient.fetchPlacesData(location: "40.7484,-73.9857", seachType: .Nearby, textSearch: nil) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                //TODO: show alert
            case .success(let places):
                print("RESULTS COUNT: \(places.count)")
            }
        }
    }
    
    func testEndpoint() {
        let location = "40.7484,-73.9857"
        let endpoint = NetworkClient.endpoint(searchType: .Text, location: location, textSearch: "bakery")
        print(endpoint ?? "BAD ENDPOINT")
    }


}
