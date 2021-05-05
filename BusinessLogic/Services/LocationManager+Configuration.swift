//
//  LocationManager+Configuration.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import CoreLocation


extension LocationManager {
    struct Configuration {
        let locationAccuracy: Double
        let distanceFilter: Double
        let requestsAlwaysAuthorization: Bool
        let pausesAutomatically: Bool
        let monitorsLocationIndefinitely: Bool
        let monitorsHeading: Bool
        let monitorsSignificantLocationChanges: Bool
        
        init(locationAccuracy: CLLocationAccuracy, distanceFilter: Double, requestsAlwaysAuthorization: Bool = false, pausesAutomatically: Bool = true, monitorsLocationIndefinitely: Bool = true, monitorsHeading: Bool = true, monitorsSignificantLocationChanges: Bool = true) {
            self.requestsAlwaysAuthorization = requestsAlwaysAuthorization
            self.pausesAutomatically = pausesAutomatically
            self.locationAccuracy = locationAccuracy
            self.distanceFilter = distanceFilter
            self.monitorsHeading = monitorsHeading
            self.monitorsLocationIndefinitely = monitorsLocationIndefinitely
            self.monitorsSignificantLocationChanges = monitorsSignificantLocationChanges
        }
        
        static var `default`: Configuration {
            return Configuration(locationAccuracy: kCLLocationAccuracyNearestTenMeters, distanceFilter: 5.0)
        }
    }
}


