//
//  HomeViewModel.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 31.07.2022.
//

import Foundation
import UIKit

class HomeViewModel {
        
    var dataSource: [LocationWeatherData] = []
    var model: MainModel!
    
    init(model: MainModel) {
        self.model = model
    }
    
    func loadDataSource(completion: @escaping (() -> Void)) {
        model.loadDataSource { [weak self] dataSource in
            self?.dataSource = dataSource
            completion()
        }
    }
    
    func loadWeatherImage(imageCode: String, completion: @escaping (UIImage?) -> Void) {
        model.loadWeatherImage(imageCode: imageCode, completion: completion)
    }
    
}
