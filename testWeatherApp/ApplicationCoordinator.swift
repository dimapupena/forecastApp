//
//  ApplicationCoordinator.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 30.07.2022.
//

import Foundation

class ApplicationCoordinator: BaseCoordinator {
    
    private let model = MainModel()
    
    override func start() {
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let homeViewModel = HomeViewModel(model: model)
        let viewController = HomeViewController(viewModel: homeViewModel)
        viewController.onForecast = { [weak self] weatherData in
            self?.showForecast(weatherData)
        }
        router.pushViewController(viewController, animated: true)
    }
    
    private func showForecast(_ weatherData: LocationWeatherData) {
        let forecastViewModel = ForecastViewModel(weatherData: weatherData, model: model)
        let forecastViewController = ForecastViewController(viewModel: forecastViewModel)
        router.pushViewController(forecastViewController, animated: true)
    }
    
}
