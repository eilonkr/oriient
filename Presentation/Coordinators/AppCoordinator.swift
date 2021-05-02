//
//  AppCoordinator.swift
//  Oriient√
//
//  Created by Eilon Krauthammer on 01/05/2021.
//

import UIKit
import EKSwiftSuite

final class AppCoordinator: BaseCoordinator<UINavigationController> {
    
    private let window: UIWindow
    
    let mapModule: MapModule
    
    init(scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        
        let state = MapState(mapConfiguration: .default)
        mapModule = MapModule(state: state)
        
        let navigationController = UINavigationController(rootViewController: mapModule.viewController)
        super.init(rootViewController: navigationController)
        window.rootViewController = navigationController
        
        mapModule.output = self
    }
    
    override func start() {
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: MapModuleOutput {
    
}
