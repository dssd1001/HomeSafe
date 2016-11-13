//
//  Intersection.swift
//  HomeSafe
//
//  Created by David Lee on 11/12/16.
//
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    var radius: Double?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.radius = 0
    }
}
