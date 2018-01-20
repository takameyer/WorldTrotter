import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
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
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
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
        
        // Show my location
        
        
        print( "MapViewController loaded its view." )
    }
    
    @objc func myLocationButtonTapped(sender: UIButton!){
        print( "You pressed me!" )
        mapView.showsUserLocation = true
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
