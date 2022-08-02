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
    var searchList: [LocationWeatherData] = []
    var searching: Bool = false
    var model: MainModel!
    
    init(model: MainModel) {
        self.model = model
    }
    
    func updateSearchList(searchText: String) {
        if searchText != "" {
            searchList = dataSource.filter { $0.location.placeName.lowercased().contains(searchText.lowercased()) }
        } else {
            searchList = dataSource
        }
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
