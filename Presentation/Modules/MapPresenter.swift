//
//  MapPresenter.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import Foundation
import CoreLocation

final class MapPresenter {
    
    weak var view: MapViewInput?
    weak var output: MapModuleOutput?
    
    let state: MapState
    
    private lazy var locationManager: LocationManager = {
        let manager = LocationManager(configuration: .default)
        manager.onAuthorizationStatusChange = { [unowned self] _ in
            handleAuthorizationStatusChange()
        }
        return manager
    }()
    
    init(state: MapState) {
        self.state = state
    
    }
    
    private func handleAuthorizationStatusChange() {
        if locationManager.isAuthorized {
            getLocation()
        } else {
            #if DEBUG
            print("Location unauthorized")
            #endif
        }
    }
    
    private func getLocation() {
        locationManager.startMonitoringLocation { [weak self] location in
            guard let self = self else { return }
            if let location = location {
                self.getPlaces(with: location.coordinate)
            }
            
            self.state.location = location
            self.update()
        } headingCallback: { [weak self] direction in
            self?.state.bearing = direction
            self?.update()
        }
    }
    
    private func getPlaces(with locationCoordinate: CLLocationCoordinate2D) {
        view?.startLoadingInterface(infoText: "Getting nearby places...")
        
        let placesRequest = FindPlaceRequest(coordinate: locationCoordinate, radius: Constants.Map.cameraHeightInMeters)
        placesRequest.make(expect: PlacesContainer.self) { [weak self] result in
            guard let self = self else { return }
            self.view?.stopLoadingInterface()
            
            switch result {
                case .success(let placesContainer):
                    let places = Array(placesContainer.results.prefix(upTo: Constants.Map.maximumNearbyPlacesToShow))
                    self.state.places = places
                    // Optional – append places instead of replacing.
                    // self.state.places += places.filter { !self.state.places.contains($0) }
                    self.update()
                case .failure(let error):
                    print(error)
            }
        }
    }
}

extension MapPresenter: MapViewOutput {
    func viewDidLoad() {
        if !locationManager.isAuthorized {
            locationManager.requestAuthorizationIfNeeded()
        } else {
            getLocation()
        }
    }
}

extension MapPresenter: MapModuleInput {
    func update(force: Bool = false, animated: Bool = true) {
        let viewModel = MapViewModel(state: self.state)
        view?.update(with: viewModel, force: force, animated: animated)
    }
}
