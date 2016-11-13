//
//  MapViewController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate {
    
    /*
     Add UITextField for Current/Destination locations.
     1. Current = default Cal, unless location services on, then current location.
     2. Algorithm for calculating safest path.
     3. Execute algorithm, update map with path.
     */
    let lM = CLLocationManager()
    
    var map = MKMapView(frame: UIScreen.main.bounds)
    
    var userLocation: CLLocationCoordinate2D!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        view.addSubview(map)
        
        lM.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            lM.delegate = self
            lM.desiredAccuracy = kCLLocationAccuracyHundredMeters
            lM.requestLocation()
        }
        
        let destinationUI:UIView = UIView(frame: CGRect(x: 5, y: 70, width: view.frame.width - 10, height: 50))
        destinationUI.backgroundColor = UIColor.white
        view.addSubview(destinationUI)
        
        let destinationField:UITextField = UITextField(frame: CGRect(x: 5, y: 70, width: view.frame.width - 10, height: 50))
        destinationField.placeholder = "Enter your destination"
        destinationField.textAlignment = .center
        view.addSubview(destinationField)
        
        map.showsUserLocation = true
        
    }
    
    let regionRadius: CLLocationDistance = 500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue = manager.location!.coordinate
        userLocation = locValue
        
        centerMapOnLocation(location: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
        
        let annotation = ColorPointAnnotation(pinColor: UIColor.blue)
        annotation.coordinate = userLocation
        map.addAnnotation(annotation)
        
//        map.showAnnotations(map.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            let colorPointAnnotation = annotation as! ColorPointAnnotation
            pinView?.pinTintColor = colorPointAnnotation.pinColor
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
