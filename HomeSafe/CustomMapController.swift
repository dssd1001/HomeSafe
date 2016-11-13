//
//  CustomMapController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/13/16.
//
//

import UIKit
import MapKit

class CustomMapController: UIViewController, CLLocationManagerDelegate {
    
    let lM = CLLocationManager()
    var map = MKMapView(frame: UIScreen.main.bounds)
    var userLocation: CLLocationCoordinate2D!
    var ntitle: String?
    
    var eventButton: UIButton!
    let eventPicker = UIPickerView(frame: CGRect(x: 5, y: 70 + 150, width: UIScreen.main.bounds.width - 10, height: 100))
    let pickerDataSource = ["Select an Incident", "Theft", "Burglary", "Assault", "Shooting", "Loitering", "Fire"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = ntitle
        
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
        
        map.showsUserLocation = true
        
    }
    let regionRadius: CLLocationDistance = 500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
