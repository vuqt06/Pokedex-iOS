//
//  CacheService.swift
//  Pokedex
//
//  Created by Vu Trinh on 9/11/22.
//

import Foundation
import SwiftUI
// Cache to store loaded images
class CacheService {
    
    // Stores the Image components with URL string as key
    private static var imageCache = [String: Image]()
    
    /// Return image for given key, Nil means image doesn't exist in cache
    static func getImage(forKey: String) -> Image? {
        return imageCache[forKey]
    }
    
    /// Stores the image component in cache with given key
    static func setImage(image: Image, forKey: String) {
        imageCache[forKey] = image
    }
}
