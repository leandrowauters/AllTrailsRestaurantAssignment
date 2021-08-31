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
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchNearbyButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: VIEWS
    private var listTableView = ListTableView()
    private var mapView = MapView()
    private var restaurantView: RestaurantView!
    
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
    var lastSelectedAnnotationView: MKAnnotationView?
    
    //MARK: CORE LOCATION PROPERTIES
    private var locationManager = CLLocationManager()
    private var userCoordinate: CLLocationCoordinate2D? {
        didSet {
            searchReastaurant(searchType: .Nearby, text: nil)
        }
    }
    //Default location: NYC
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupUI()
        setupCoreLocation()
    }
    
    //MARK: UI FUNCTIONS
    private func setupUI() {
        topView.backgroundColor = Constants.secondaryColor
        contentButton.setAsContentButton()
        setupViewsUI()
        setupContentButtonUI()
        setupSearchNearByButton()
    }
    
    private func setupSearchNearByButton() {
        searchNearbyButton.setAsSearchNearbyButton()
    }
    private func setupContentButtonUI() {
        
        if !mapView.isHidden {
            //MAP VIEW SHOWING
            contentButton.setTitle("Map", for: .normal)
            contentButton.setImage(Constants.mapImape, for: .normal)
        } else {
            //LIST VIEW SHOWING
            contentButton.setTitle("List", for: .normal)
            contentButton.setImage(Constants.listImage, for: .normal)
        }
    }
    private func setupViewsUI() {
        setupListTableView()
        setupMapView()
        setupRestaurantView()
    }
    
    private func setupTextField() {
        searchTextField.delegate = self
    }
    private func setupRestaurantView() {
        restaurantView = RestaurantView.instanceFromNib()
        restaurantView.setupUI(width: contentView.frame.size.width * 0.75, height: contentView.frame.size.height * 0.175)
        
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
    
    private func didSelectedAnnotationView(selected: MKAnnotationView) {
        if lastSelectedAnnotationView != nil {
            lastSelectedAnnotationView!.image = Constants.unselectedPin
            
        }
            selected.image = Constants.selectedPin
            lastSelectedAnnotationView = selected
        
    }
    private func addAnnotations(restaurants: [Restaurant]) {
        
        mapView.removeAnnotations(self.annotations)
        self.annotations.removeAll()
        for restaurant in restaurants {
            self.annotations.append(restaurant)
        }
        
        mapView.addAnnotations(self.annotations)
        centerMap(coordinate: userCoordinate!)
    }
    
    //MARK: CORE LOCATION FUNCTIONS
    private func setupCoreLocation() {
        locationManager.delegate = self
        requestLocationPersmissions()
        
        
    }
    
    private func requestLocationPersmissions() {
      locationManager.requestWhenInUseAuthorization()
    }
    
    private func centerMap(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: Constants.regionRadius, longitudinalMeters: Constants.regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        //MARK: THIS SHOULD BE CHECK!
        
    }
    
    private func toggleContentViews() {
        mapView.isHidden.toggle()
        listTableView.isHidden.toggle()
        setupContentButtonUI()
    }
    
    @IBAction func contentViewButtonPressed(_ sender: Any) {
        toggleContentViews()
    }
    
    @IBAction func didPressSearchNearby(_ sender: Any) {
        searchReastaurant(searchType: .Nearby, text: nil)
    }
    
    
    func searchReastaurant(searchType: NetworkClient.SearchType, text: String?) {
        
        guard let userCoordinate = self.userCoordinate else {
            return
        }
        
        NetworkClient.fetchPlacesData(location: userCoordinate.urlQueryItemString(), seachType: searchType, textSearch: text) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.showAlert(title: "Error searching nearby", message: error.localizedDescription)
            case .success(let places):
                let restaurants = Restaurant.getRestuarants(places: places)
                self?.restaurants = restaurants
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
        let restaurant = restaurants[indexPath.row]
        guard let listCell = listTableView.dequeueReusableCell(withIdentifier: "listCell") as? ListTableViewCell else {
            fatalError("Error loading cell")
        }
        listCell.restaurantCellDelegate = self
        listCell.configureCell(with: restaurant, tag: indexPath.row)
        return listCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


//MARK: MAPVIEW DELEGATE FUNCTIONS

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let restaurantAnnotation = view.annotation as? Restaurant else {
            return
        }
        
        didSelectedAnnotationView(selected: view)
        restaurantView.configure(with: restaurantAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Restaurant else { return nil }
        let annotationView = MKAnnotationView()
        annotationView.image = Constants.unselectedPin
        annotationView.detailCalloutAccessoryView = restaurantView
        annotationView.canShowCallout = true
        
        return annotationView
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
        case .denied:
          print("denied")
          centerMap(coordinate: Constants.defultCoordinate)
        default:
          break
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {return}
//        centerMap(coordinate: currentLocation.coordinate)
        if userCoordinate == nil {
        userCoordinate = currentLocation.coordinate
            locationManager.stopUpdatingLocation()
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        if text == "" {
            print("NO SEARCH")
            textField.text = ""
            textField.endEditing(true)
            
        } else {
            searchReastaurant(searchType: .Text, text: text)
            textField.text = ""
            textField.endEditing(true)
        }
        
        print(text)
        return true
    }
}

extension MainViewController: RestaurantCellDelegate {
    func didPressFavorite(tag: Int) {
        let restaurant = restaurants[tag]
        restaurant.setFavorite()
        listTableView.reloadData()
    }
}
