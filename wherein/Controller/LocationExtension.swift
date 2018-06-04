//
//  LocationExtension.swift
//  wherein
//
//  Created by christophe milliere on 19/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import NMAKit
import MapKit

extension MapViewController: CLLocationManagerDelegate {
    
    func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.count > 0 else { return }
        locationManager?.stopUpdatingLocation()
//        let postionCurrent = locations[0]
        locationCurrent = locations[0]
//        let lat = postionCurrent.coordinate.latitude
//        let lng = postionCurrent.coordinate.longitude
//
//        print("lat \(lat) et lng \(lng)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
