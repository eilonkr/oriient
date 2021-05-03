//
//  PlacesRequests.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 02/05/2021.
//

import CoreLocation
import EKSwiftSuite

struct FindPlaceRequest {
    let coordinate: CLLocationCoordinate2D
    let radius: Double
}

extension FindPlaceRequest: HTTPRequest {
    var endpoint: Endpoint { PlaceEndpoint.findPlace }
    var method: HTTPMethod { .get }
    
    var headers: [String : String] {[
        "Content-Type": "application/json"
    ]}
    
    var queryParams: [String : String]? {[
        "key": Constants.Keys.googleMapsAPIKey,
        "radius": "\(radius)",
        "location": "\(coordinate.latitude),\(coordinate.longitude)"
    ]}
}
