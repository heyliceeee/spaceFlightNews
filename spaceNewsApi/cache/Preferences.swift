//
//  Preferences.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 02/02/2022.
//

import UIKit

class Preferences: NSObject {
    
    var fontSize: Float = 17.0
    
    
    func setfontSize (FontSize: Float) {
        fontSize = FontSize
    }
    
    func getfontSize() -> Float {
        return self.fontSize
    }
}
