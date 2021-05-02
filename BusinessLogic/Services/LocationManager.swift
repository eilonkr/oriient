//
//  LocationManager.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import UIKit
import CoreLocation

final class LocationManager: NSObject {
    typealias LocationCallback = (CLLocation?) -> Void
    typealias HeadingCallback = (CLLocationDirection?) -> Void
    
    public var lastLocation: CLLocation?
    public var onAuthorizationStatusChange: ((CLAuthorizationStatus) -> Void)?
    public var authorizationStauts: CLAuthorizationStatus { CLLocationManager.authorizationStatus() }
    
    public var isAuthorized: Bool {
        return authorizationStauts == .authorizedAlways ||
                authorizationStauts == .authorizedWhenInUse ||
                authorizationStauts == .restricted
    }
    
    public var configuration: Configuration
    
    private let manager: CLLocationManager = CLLocationManager()
    
    private var locationCallback: LocationCallback?
    private var headingCallback: HeadingCallback?
        
    init(configuration: Configuration) {
        self.configuration = configuration
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = configuration.locationAccuracy
        manager.pausesLocationUpdatesAutomatically = configuration.pausesAutomatically
    }
    
    public func requestAuthorizationIfNeeded() {
        guard authorizationStauts == .notDetermined else { return }
        if configuration.requestsAlwaysAuthorization {
            manager.requestAlwaysAuthorization()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    public func startMonitoringLocation(locationCallback: LocationCallback?, headingCallback: HeadingCallback?) {
        assert(isAuthorized, "No location authorization.")
        
        self.locationCallback = locationCallback ?? self.locationCallback
        self.headingCallback = headingCallback ?? self.headingCallback
        manager.startUpdatingLocation()
        
        if configuration.monitorsHeading {
            manager.startUpdatingHeading()
        }
        
        if configuration.monitorsSignificantLocationChanges {
            manager.startMonitoringSignificantLocationChanges()
        }
    }
    
    public func stopMonitoringLocation() {
        manager.stopUpdatingLocation()
        manager.stopMonitoringSignificantLocationChanges()
        manager.stopUpdatingHeading()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !configuration.monitorsLocationIndefinitely {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
            manager.stopUpdatingHeading()
        }
        
        let location = locations.last
        lastLocation = location
        locationCallback?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingCallback?(newHeading.trueHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        manager.stopMonitoringSignificantLocationChanges()
        locationCallback?(nil)
        print("Location manager failed with error:")
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        onAuthorizationStatusChange?(status)
    }
}

