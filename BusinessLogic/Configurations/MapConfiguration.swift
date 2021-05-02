//
//  MapConfiguration.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import CoreLocation

struct MapConfiguration: Equatable {
    let showsCurrentLocation: Bool
    let showsCurrentLocationButton: Bool
    let cameraZoom: Float
    let noLocationCameraLocation: CLLocation
        
    static var `default`: MapConfiguration {
        MapConfiguration(
            showsCurrentLocation: true,
            showsCurrentLocationButton: false,
            cameraZoom: 12,
            noLocationCameraLocation: .init(latitude: 49.26, longitude: -123.11) // Vancouver I think?
        )
    }
}

