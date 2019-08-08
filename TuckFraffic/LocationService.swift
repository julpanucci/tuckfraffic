//
//  LocationService.swift
//  TuckFraffic
//
//  Created by Panucci, Julian on 8/8/19.
//  Copyright © 2019 Panucci. All rights reserved.
//

import Foundation
import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate {

    static let shared = LocationService()
    private var authCase = CLAuthorizationStatus.notDetermined {
        didSet {
            switch authCase {
            case .notDetermined:
                 authStatus = "Not Determined"
            case .authorizedAlways:
                authStatus = "Always"
            case .authorizedWhenInUse:
                authStatus = "When in use"
            case .denied:
                authStatus = "Denied"
            case .restricted:
                authStatus = "Restricted"
            default:
                authStatus = "Not Determined"
            }

            onLocationUpdated?()
        }
    }

    var authStatus: String = ""
    private let locationManager = CLLocationManager()
    var onSpeedChange: ((String) -> ())?
    var onLocationUpdated: (() -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
    }

    func requestLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy =  kCLLocationAccuracyBestForNavigation
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }

        if var speed = locationManager.location?.speed {
            if speed < 0 {
                speed = 0.0
            }
            onSpeedChange?(speed.description)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authCase = status
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
