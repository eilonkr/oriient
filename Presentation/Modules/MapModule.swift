//
//  MapModule.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import Foundation

protocol MapModuleInput: AnyObject {
    var state: MapState { get }
    func update(force: Bool, animated: Bool)
}

protocol MapModuleOutput: AnyObject {
    
}

final class MapModule {

    public var input: MapModuleInput {
        return presenter
    }
    public var output: MapModuleOutput? {
        get {
            presenter.output
        } set {
            presenter.output = newValue
        }
    }
    
    public let viewController: MapViewController
    private let presenter: MapPresenter

    init(state: MapState) {
        let presenter = MapPresenter(state: state)
        let viewModel = MapViewModel(state: state)
        let viewController = MapViewController(viewModel: viewModel, output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
