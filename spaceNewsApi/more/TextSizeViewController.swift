//
//  TextSizeViewController.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 02/02/2022.
//

import UIKit

class TextSizeViewController: UIViewController {
    
    private let cacheManager = CacheManager()
    
    var preferences: Preferences = Preferences()
    
    private let defaultTitleFontSize = 20.0
    
    static let identifier = "TextSizeViewController"
    
    @IBOutlet weak var lbl_SizeEx: UILabel!
    @IBOutlet weak var lbl_fontSize: UILabel!
    @IBOutlet weak var slider_fontSize: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set Label Text
        lbl_fontSize.text = "\(cacheManager.getCachedFontSize() ?? Float(defaultTitleFontSize))"
        //set Label FontSize
        lbl_SizeEx.font = lbl_SizeEx.font.withSize(CGFloat(cacheManager.getCachedFontSize() ?? Float(defaultTitleFontSize)))
        
        //set Slider Value
        slider_fontSize.value = cacheManager.getCachedFontSize() ?? Float(defaultTitleFontSize)

    }
    @IBAction func sliderOnValueChange(_ sender: Any) {
        
        //Round Slider value to .5
        let value = roundf(slider_fontSize.value * 2.0) * 0.5
        
        //Save FontSize in cache
        cacheManager.cacheFontSize(fontSize: value)
        
        //set label text
        lbl_fontSize.text = "\(cacheManager.getCachedFontSize()!)"
        
        //set label FontSize
        lbl_SizeEx.font = lbl_SizeEx.font.withSize(CGFloat(cacheManager.getCachedFontSize()!))
    }
}
