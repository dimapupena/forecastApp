//
//  Date.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
