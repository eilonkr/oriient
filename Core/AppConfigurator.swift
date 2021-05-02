//
//  AppConfigurator.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import UIKit
import GoogleMaps

struct AppConfigurator {
    static func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureGoogleMaps()
        
        return true
    }
    
    private static func configureGoogleMaps() {
        GMSServices.provideAPIKey(Constants.Keys.googleMapsAPIKey)
    }
}
