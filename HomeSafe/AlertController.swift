//
//  AlertController.swift
//  HomeSafe
//
//  Created by Natsuki Takahari on 11/12/16.
//
//

import UIKit
import MapKit

class AlertController: UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {

    let lM = CLLocationManager()
    var map = MKMapView(frame: UIScreen.main.bounds)
    var userLocation: CLLocationCoordinate2D!
    
    var eventButton: UIButton!
    let eventPicker = UIPickerView(frame: CGRect(x: 5, y: 70 + 150, width: UIScreen.main.bounds.width - 10, height: 100))
    let pickerDataSource = ["Select an Incident", "Theft", "Burglary", "Assault", "Shooting", "Loitering", "Fire"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "HomeSafe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.doneAdding(_:)))
        
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
        
        let postUI:UIView = UIView(frame: CGRect(x: 5, y: 70, width: view.frame.width - 10, height: 150))
        postUI.backgroundColor = UIColor.gray
        view.addSubview(postUI)
        
        let postTitle:UITextField = UITextField(frame: CGRect(x: 15, y: 75, width: view.frame.width - 30, height: 30))
        postTitle.placeholder = "Report Title"
        postTitle.delegate = self
        view.addSubview(postTitle)
        
        let postView:UITextView = UITextView(frame: CGRect(x: 10, y: 70 + 30, width: view.frame.width - 20, height: 150 - 30))
        postView.font = UIFont.systemFont(ofSize: 18)
        postView.backgroundColor = UIColor.clear
        postView.delegate = self
        view.addSubview(postView)
        
        view.addSubview(postLabel)
        
        eventButton = UIButton(frame: CGRect(x: 5, y: 70 + (150 - 40), width: UIScreen.main.bounds.width - 10, height: 40))
        eventButton.backgroundColor = UIColor.white
        eventButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        eventButton.setTitle("Select an Incident", for: UIControlState.normal)
        eventButton.addTarget(self, action: #selector(self.toggleEventOn(_:)), for: .touchUpInside)
        view.addSubview(eventButton)
        
        map.showsUserLocation = true
        
        eventPicker.backgroundColor = UIColor.white
        eventPicker.delegate = self
        eventPicker.dataSource = self
        eventPicker.isHidden = true
        
        view.addSubview(eventPicker)
        
    }
    
    func doneAdding(_ sender: UIBarButtonItem) {
        let presentingViewController: UIViewController! = self.presentingViewController
        
        self.dismiss(animated: false) {
            // go back to MainMenuView as the eyes of the user
            presentingViewController.dismiss(animated: false, completion: nil)
        }
    }
    
    let postLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 70 + 30, width: UIScreen.main.bounds.width - 30, height: 30))
        label.text = "What do you want to report?"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    func textViewDidChange(_ textView: UITextView) {
        postLabel.isHidden = textView.hasText
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 50
    }
    
    func toggleEventOn(_ sender: UIButton) {
        if (eventPicker.isHidden) {
            eventPicker.isHidden = false
        }
        else {
            eventPicker.isHidden = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventButton.setTitle(pickerDataSource[row], for: UIControlState.normal)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
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
