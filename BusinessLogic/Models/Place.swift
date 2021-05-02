//
//  Place.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 02/05/2021.
//

import CoreLocation

struct PlacesContainer: Decodable {
    let results: [Place]
}

struct Place: Decodable, Equatable {
    let name: String
    let geometry: Geo
}

extension Place {
    struct Geo: Decodable, Equatable {
        let location: Location
    }
    
    struct Location: Decodable, Equatable {
        let lat: Double
        let lng: Double
        
        var coordinate2d: CLLocationCoordinate2D {
            .init(latitude: lat, longitude: lng)
        }
    }
}

