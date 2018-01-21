import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
     
        addSegmentedControl(view)
        addMyLocationButton(view)
    }
    
    func addMyLocationButton(_ view: UIView){
        
        let myLocationButton = UIButton(type: .system)
        myLocationButton.frame = CGRect(x: 75, y: 75, width: 75, height: 75)
        myLocationButton.backgroundColor = UIColor.lightGray
        myLocationButton.setImage(UIImage(named: "myLocationIcon"), for: UIControlState.normal)
        myLocationButton.addTarget(self, action: #selector(myLocationButtonTapped), for: UIControlEvents.touchUpInside)
        myLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myLocationButton)
        
        let margins = view.layoutMarginsGuide
        let trailingConstraint = myLocationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let bottomConstraint = myLocationButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -12
        )
        
        trailingConstraint.isActive = true
        bottomConstraint.isActive = true
    }
    
    func addSegmentedControl(_ view: UIView){
    
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(
            self,
            action: #selector(MapViewController.mapTypeChanged(_:)),
            for: .valueChanged
        )
        
        view.addSubview(segmentedControl)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let topConstraint = segmentedControl.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 8
        )
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print( "MapViewController loaded its view." )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(
            latitude: userLocation.coordinate.latitude,
            longitude: userLocation.coordinate.longitude
        )
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
        mapView.setRegion(region, animated: true)
        
    }
    

    @objc func myLocationButtonTapped(sender: UIButton!){
        mapView.showsUserLocation = true
        determineCurrentLocation()
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .hybrid
            case 2:
                mapView.mapType = .satellite
            default:
                break
        }
    }
}
