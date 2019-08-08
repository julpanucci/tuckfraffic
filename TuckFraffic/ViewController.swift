//
//  ViewController.swift
//  TuckFraffic
//
//  Created by Panucci, Julian on 8/8/19.
//  Copyright © 2019 Panucci. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let locationService = LocationService.shared
    var speedLabel = UILabel()
    var authLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSpeedLabel()
        self.setupAuthLabel()
        self.locationServiceListeners()

        locationService.requestLocation()
        locationService.startUpdatingLocation()
    }

    func locationServiceListeners() {
        locationService.onLocationUpdated = {
            self.authLabel.text = "Location status: \(self.locationService.authStatus)"
        }

        locationService.onSpeedChange = { speed in
            DispatchQueue.main.async {
                self.speedLabel.text = speed
            }
        }
    }

    func setupSpeedLabel() {
        speedLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        speedLabel.center = view.center
        speedLabel.font = UIFont.systemFont(ofSize: 60)
        speedLabel.text = "0.0"
        speedLabel.textAlignment = .center
        self.view.addSubview(speedLabel)
    }

    func setupAuthLabel() {
        authLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        authLabel.center.x = view.center.x
        authLabel.center.y = speedLabel.center.y + 50.0
        authLabel.font = UIFont.systemFont(ofSize: 16.0)
        authLabel.text = "Location Auth Status: \(locationService.authStatus)"
        authLabel.textAlignment = .center
        self.view.addSubview(authLabel)
    }
}

