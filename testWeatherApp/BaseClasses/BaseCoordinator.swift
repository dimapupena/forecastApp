//
//  BaseCoordinator.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 30.07.2022.
//

import Foundation
import UIKit

class BaseCoordinator: NSObject {
    var childCoordinators: [BaseCoordinator] = []
    var router: UINavigationController
    
    init(router: UINavigationController) {
        self.router = router
    }
    
    func start() {
        
    }
    
    func addChild(_ coordinator: BaseCoordinator) {
        guard !childCoordinators.contains(where: {$0 === coordinator}) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: BaseCoordinator) {
        guard !childCoordinators.isEmpty else { return }
        coordinator.removeAllChildren()
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func removeAllChildren(){
        childCoordinators = []
    }
}
