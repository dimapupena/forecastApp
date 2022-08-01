//
//  HomeViewModel.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 31.07.2022.
//

import Foundation

class HomeViewModel {
        
    var model: MainModel!
    
    init(model: MainModel) {
        self.model = model
    }
    
    func getData() {
        model.getData()
    }
    
}
