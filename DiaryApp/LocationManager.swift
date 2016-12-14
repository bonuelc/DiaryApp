//
//  LocationManager.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/11/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import CoreLocation

class LocationManager: CLLocationManager {
    
    // MARK: - Properties
    
    let geocoder = CLGeocoder()
    
    var onLocationFix: ((CLPlacemark?, NSError?) -> Void)? {
        didSet {
            requestLocation()
        }
    }
    
    override init() {
        super.init()
        
        self.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .NotDetermined: requestWhenInUseAuthorization()
        case .AuthorizedWhenInUse, .AuthorizedAlways: requestLocation()
        default: break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            requestLocation()
        }
    }
}