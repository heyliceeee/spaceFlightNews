//
//  TextSizeViewController.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 02/02/2022.
//

import UIKit

class TextSizeViewController: UIViewController {
    
    var preferences: Preferences = Preferences()
    
    static let identifier = "TextSizeViewController"
    
    @IBOutlet weak var lbl_SizeEx: UILabel!
    @IBOutlet weak var lbl_fontSize: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_fontSize.text = "\(preferences.getfontSize())"
        
        lbl_SizeEx.font = lbl_SizeEx.font.withSize(CGFloat(preferences.getfontSize()))
    }
}
