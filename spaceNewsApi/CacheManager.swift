//
//  CacheManager.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 02/02/2022.
//

import Foundation

struct CacheManager {
    
    private let vault = UserDefaults.standard
    
    enum Key: String {
        case fontSize
    }
    
    func cacheFontSize (fontSize: Float) {
        vault.set(fontSize, forKey: Key.fontSize.rawValue)
    }
    
    func getCachedFontSize() -> Float? {
        return vault.value(forKey: Key.fontSize.rawValue) as? Float
    }
}
