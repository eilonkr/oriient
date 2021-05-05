//
//  MapViewController.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import UIKit
import EKSwiftSuite
import GoogleMaps

protocol MapViewInput: UIViewController {
    func update(with viewModel: MapViewModel, force: Bool, animated: Bool)
}

protocol MapViewOutput: AnyObject {
    func viewDidLoad()
}

final class MapViewController: UIViewController {
    
    private var mapView: GMSMapView!
    
    var output: MapViewOutput
    private var viewModel: MapViewModel
    
    private var markers: [GMSMarker] = []
    
    init(viewModel: MapViewModel, output: MapViewOutput) {
        self.output = output
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "oriient"
        configureMapView()
        output.viewDidLoad()
    }
    
    private func configureMapView() {
        mapView = GMSMapView()
        mapView.fix(in: view)
        mapView.isMyLocationEnabled = viewModel.mapConfiguration.showsCurrentLocation
        mapView.settings.myLocationButton = viewModel.mapConfiguration.showsCurrentLocationButton
        let cameraCoordinate = viewModel.location?.coordinate ?? viewModel.mapConfiguration.noLocationCameraLocation.coordinate
        mapView.camera = GMSCameraPosition.camera(withTarget: cameraCoordinate, zoom: viewModel.mapConfiguration.cameraZoom)
    }
    
    private func add(place: Place) {
        let marker = GMSMarker(position: place.geometry.location.coordinate2d)
        marker.title = place.name
        marker.snippet = place.name
        marker.map = mapView
        markers.append(marker)
    }
    
    private func remove(place: Place) {
        guard let markerIndex = markers.firstIndex(where: {
            $0.position.latitude == place.geometry.location.lat && $0.position.longitude == place.geometry.location.lng
        }) else {
            return
        }
        markers[markerIndex].map = nil
        markers.remove(at: markerIndex)
    }
}

extension MapViewController: MapViewInput, ForceViewUpdate {
    func update(with viewModel: MapViewModel, force: Bool, animated: Bool) {
        update(new: viewModel, old: self.viewModel, keyPath: \.location, force: force) { location in
            // Animate to current location only once for convenience.
            // Comment / remove the following line to animate to current location as updates come in.
            guard self.viewModel.location == nil else { return }
            
            let cameraCoordinate = viewModel.location?.coordinate ?? viewModel.mapConfiguration.noLocationCameraLocation.coordinate
            mapView.animate(toLocation: cameraCoordinate)
        }
        
        update(new: viewModel, old: self.viewModel, keyPath: \.places, force: force) { places in
            for place in places where !self.viewModel.places.contains(place) {
                add(place: place)
            }
            
            for place in self.viewModel.places where !places.contains(place) {
                remove(place: place)
            }
        }
        
        /// Playing with bearing / heading right here.
        /// Uncomment to animate continuosly based on user heading.
        //  update(new: viewModel, old: self.viewModel, keyPath: \.bearing, force: force) { bearing in
        //      guard let bearing = bearing else { return }
        //      mapView.animate(toBearing: bearing)
        //  }
     
        self.viewModel = viewModel
    }
}

