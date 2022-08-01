//
//  ApplicationCoordinator.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 30.07.2022.
//

import Foundation

class ApplicationCoordinator: BaseCoordinator {
    
    override func start() {
        showViewController()
    }
    
    private func showViewController() {
        var viewController = ViewController()
        router.pushViewController(viewController, animated: true)
    }
    
}
