//
//  PlaceEndpoint.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 02/05/2021.
//

import Foundation

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
