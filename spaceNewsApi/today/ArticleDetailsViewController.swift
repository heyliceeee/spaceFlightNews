//
//  ArticleDetailsViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 18/01/2022.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var lbl_ID: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    
    
    var id = ""
    var img = UIImage()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        lbl_ID.text = id
        image.image = img
    }
}
