//
//  MapViewModel.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import Foundation
import CoreLocation

struct MapViewModel {
    
    let mapConfiguration: MapConfiguration
    let location: CLLocation?
    let bearing: CLLocationDirection?
    let places: [Place]
    
    init(state: MapState) {
        self.mapConfiguration = state.mapConfiguration
        self.location = state.location
        self.bearing = state.bearing
        self.places = state.places
    }
    
}
