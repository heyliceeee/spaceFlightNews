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
        case appearance
        case searchResult
    }
    
    func cacheFontSize (fontSize: Float) {
        vault.set(fontSize, forKey: Key.fontSize.rawValue)
    }
    
    func getCachedFontSize() -> Float? {
        return vault.value(forKey: Key.fontSize.rawValue) as? Float
    }
    
    func cacheAppearance (appearance: Bool) {
        vault.set(appearance, forKey: Key.appearance.rawValue)
    }
    
    func getCacheAppearance() -> Bool? {
        return vault.value(forKey: Key.appearance.rawValue) as? Bool
    }
    
    
    func cacheSearchResult (searchResult: String) {
        vault.set(searchResult, forKey: Key.searchResult.rawValue)
    }
    
    func getCachedSearchResult() -> String? {
        return vault.value(forKey: Key.searchResult.rawValue) as? String
    }
}
