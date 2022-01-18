//
//  ArticleDetailsViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 18/01/2022.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    //static let identifier = "ArticleDetailsViewController"
    
    var labelText = String()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        label.text = labelText
    }
}
