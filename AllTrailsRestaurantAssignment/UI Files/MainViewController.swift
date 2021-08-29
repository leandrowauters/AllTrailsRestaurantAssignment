//
//  MainViewController.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/27/21.
//

import UIKit
import MapKit
import CoreLocation
class MainViewController: UIViewController {

    
    //MARK: OUTLETS
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: VIEWS
    private var listTableView = ListTableView()
    private var mapView = MapView()
    
    //MARK: DATA:
    var restaurants = [Restaurant]() {
        didSet {
            print("Did load data. Count: \(restaurants.count)")
            DispatchQueue.main.async {
                self.listTableView.reloadData()
                self.addAnnotations(restaurants: self.restaurants)
            }
        }
    }
    
    //MARK: MAPKIT PROPERTIES:
    var annotations = [MKAnnotation]()
    
    //MARK: CORE LOCATION PROPERTIES
    private var locationManager = CLLocationManager()
    private var userCoordinate: CLLocationCoordinate2D? {
        didSet {
            searchNearby()
        }
    }
    //Default location: NYC

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment to test endpoints
//        testEndpoint()
        setupViewsUI()
        setupCoreLocation()
        
    }
    
    //MARK: UI FUNCTIONS
    private func setupViewsUI() {
        setupListTableView()
        setupMapView()
    }
    
    private func setupListTableView() {
        listTableView.setupUI(contentView: contentView)
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.isHidden = true
    }

    //MARK: MAPKIT FUNCTIONS:
    private func setupMapView() {
        mapView.setupUI(contentView: contentView)
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    
    
    private func addAnnotations(restaurants: [Restaurant]) {
        mapView.removeAnnotations(self.annotations)
    
        for restaurant in restaurants {
            self.annotations.append(restaurant)
        }
        
        mapView.addAnnotations(self.annotations)
        centerMap(coordinate: userCoordinate!)
    }
    
    //MARK: CORE LOCATION FUNCTIONS
    private func setupCoreLocation() {
        requestLocationPersmissions()
        locationManager.delegate = self
    }
    
    private func requestLocationPersmissions() {
      locationManager.requestWhenInUseAuthorization()
    }
    
    private func centerMap(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: Constants.regionRadius, longitudinalMeters: Constants.regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        //MARK: THIS SHOULD BE CHECK!
        locationManager.stopUpdatingLocation()
    }
    
    func searchNearby() {
        guard let userCoordinate = self.userCoordinate else {
            return
        }
        NetworkClient.fetchPlacesData(location: userCoordinate.urlQueryItemString(), seachType: .Nearby, textSearch: nil) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.showAlert(title: "Error searching nearby", message: error.localizedDescription)
            case .success(let places):
                let restaurants = Restaurant.getRestuarants(places: places)
                self?.restaurants.append(contentsOf: restaurants)
                
            }
        }
    }
    func testEndpoint() {
        let location = "40.7484,-73.9857"
        let endpoint = NetworkClient.endpoint(searchType: .Text, location: location, textSearch: "bakery")
        print(endpoint ?? "BAD ENDPOINT")
    }


}


// MARK: TABLE VIEW DELEGATE FUNCTIONS
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = restaurants[indexPath.row]
        guard let listCell = listTableView.dequeueReusableCell(withIdentifier: "listCell") as? ListTableViewCell else {
            fatalError("Error loading cell")
        }
        print(place.name)
        return listCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


//MARK: MAPVIEW DELEGATE FUNCTIONS

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
    }

}

//MARK: CORE LOCATION DELEGATE FUCTIONS
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .authorizedAlways:
          print("authorizedAlways")
          locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
          print("authorizedWhenInUse")
          locationManager.startUpdatingLocation()
        case .denied, .notDetermined, .restricted:
          print("denied")
          centerMap(coordinate: Constants.defultCoordinate)
        default:
          break
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {return}
        userCoordinate = currentLocation.coordinate
    }
}
