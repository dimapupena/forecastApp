//
//  CachedStorage.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 02.08.2022.
//

import Foundation
import UIKit

final class CachedStorage {
    
    static let shared = CachedStorage()
    
    private init() { }
    
    private var cachedImages: [String : UIImage] = [:]
    
    func getCachedImage(code: String) -> UIImage? {
        return cachedImages[code]
    }
    
    func putCacheImage(code: String, image: UIImage) {
        cachedImages[code] = image
    }
}
