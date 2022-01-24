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
    @IBOutlet weak var lbl_Title: UILabel!
    
    
    var id = ""
    var titleArticle = ""
    var newsSite = ""
    var publishedAt = ""
    var updatedAt = ""
    var urlArticle = ""
    var img = UIImage()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        lbl_ID.text = id
        
        lbl_Title.text = titleArticle
        //lbl_newsSite.text = newsSite
        //lbl_publishedAt.text = publishedAt
        //lbl_updatedAt.text = updatedAt
        //lbl_urlArticle.text = urlArticle
        
        image.image = img
    }
}
