//
//  LocationManager+Configuration.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import CoreLocation


extension LocationManager {
    struct Configuration {
        let locationAccuracy: CLLocationAccuracy
        let requestsAlwaysAuthorization: Bool
        let pausesAutomatically: Bool
        let monitorsLocationIndefinitely: Bool
        let monitorsHeading: Bool
        let monitorsSignificantLocationChanges: Bool
        
        init(locationAccuracy: CLLocationAccuracy, requestsAlwaysAuthorization: Bool = false, pausesAutomatically: Bool = true, monitorsLocationIndefinitely: Bool = true, monitorsHeading: Bool = true, monitorsSignificantLocationChanges: Bool = false) {
            self.requestsAlwaysAuthorization = requestsAlwaysAuthorization
            self.pausesAutomatically = pausesAutomatically
            self.locationAccuracy = locationAccuracy
            self.monitorsHeading = monitorsHeading
            self.monitorsLocationIndefinitely = monitorsLocationIndefinitely
            self.monitorsSignificantLocationChanges = monitorsSignificantLocationChanges
        }
        
        static var `default`: Configuration {
            return Configuration(locationAccuracy: kCLLocationAccuracyNearestTenMeters)
        }
    }
}


