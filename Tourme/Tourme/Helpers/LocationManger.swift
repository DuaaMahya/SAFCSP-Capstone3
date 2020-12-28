//
//  LocationManger.swift
//  Tourme
//
//  Created by Dua Almahyani on 28/12/2020.
//

import Foundation
import CoreLocation

class LocationManger: NSObject, CLLocationManagerDelegate {
    
    var locationManger = CLLocationManager()
    
    static var currentLocation = CLLocationCoordinate2D()
    
    
}

