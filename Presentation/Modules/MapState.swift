//
//  MapState.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import CoreLocation

final class MapState {
    
    let mapConfiguration: MapConfiguration
    
    var location: CLLocation?
    var bearing: CLLocationDirection?
    
    var places: [Place] = []
    
    init(mapConfiguration: MapConfiguration) {
        self.mapConfiguration = mapConfiguration
    }
    
}
