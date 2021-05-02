//
//  Place.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 02/05/2021.
//

import Foundation

struct PlacesContainer: Decodable {
    let results: [Place]
}

struct Place: Decodable {
    let name: String
    let geo: Geo
}

extension Place {
    struct Geo: Decodable {
        let location: Location
    }
    
    struct Location: Decodable {
        let lat: Double
        let lng: Double
    }
}

