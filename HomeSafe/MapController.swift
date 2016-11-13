//
//  MapViewController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
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
        map.delegate = self
        
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
        destinationField.delegate = self
        view.addSubview(destinationField)
        
        map.showsUserLocation = true
        
        // Populate with data
        
        getIncidents()
        
        let routeAnnotations = getMapAnnotations(filename: "intersections")
        
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        for annotation in routeAnnotations {
            points.append(annotation.coordinate)
        }
        let polyline = MKPolyline(coordinates: points, count: points.count)
        map.add(polyline)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //
    // Populate
    //
    
    func getIncidents() {
        let incidentAnnotations = getMapAnnotations(filename: "incidents")
        map.addAnnotations(incidentAnnotations)
        
        for incident in incidentAnnotations {
            let cir:MKCircle = MKCircle(center: incident.coordinate, radius: (incident.radius!)*1000)
            map.add(cir)
        }
    }
    
    func getMapAnnotations(filename:String) -> [Location] {
        var annotations:Array = [Location]()
        
        var locations: NSArray?
        if let path = Bundle.main.path(forResource: filename, ofType: "plist") {
            locations = NSArray(contentsOfFile: path)
        }
        
        if let items = locations {
            for item in items {
                let lat = (item as AnyObject).value(forKey: "lat") as! Double
                let long = (item as AnyObject).value(forKey: "long")as! Double
                let annotation = Location(latitude: lat, longitude: long)
                annotation.title = (item as AnyObject).value(forKey: "title") as? String
                annotation.radius = (item as AnyObject).value(forKey: "radius") as? Double
                annotations.append(annotation)
            }
        }
        return annotations
    }
    
    //
    // MKMapView
    //
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            
            polylineRenderer.strokeColor = UIColor.gray
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        
        let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
        overlayRenderer.lineWidth = 1.0
        overlayRenderer.fillColor = UIColor.red.withAlphaComponent(0.1)
        return overlayRenderer
    }
    
    //
    // CLLocationManager
    //
    
    let regionRadius: CLLocationDistance = 500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue = manager.location!.coordinate
        userLocation = locValue
        
        centerMapOnLocation(location: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
