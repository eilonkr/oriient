//
//  PlacesClient.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 02/05/2021.
//

import CoreLocation

enum PlaceEndpoint: Endpoint {
    static var baseURLPath: String { "https://maps.googleapis.com/maps/api/place/" }
    
    case findPlace
    
    var path: String {
        switch self {
            case .findPlace:
                return "nearbysearch/json"
        }
    }
}

struct FindPlaceRequest: HTTPRequest {
    let coordinate: CLLocationCoordinate2D
    let radius: Double
    
    var endpoint: Endpoint { PlaceEndpoint.findPlace }
    var method: HTTPMethod { .get }
    var headers: [String : String] { [:] }
    var queryParams: [String : String]? {[
        "key": Constants.Keys.googleMapsAPIKey,
        "radius": "radius",
        "location": "\(coordinate.latitude),\(coordinate.longitude)"
    ]}
}

