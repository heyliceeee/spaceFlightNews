//
//  ArticleDetailsViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 18/01/2022.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticleDetailsViewController: UIViewController {
    
    //@IBOutlet weak var lbl_ID: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Summary: UILabel!
    @IBOutlet weak var lbl_newsSite: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    
    var id = ""
    var titleArticle = ""
    var Summary = ""
    var newsSite = ""
    var publishedAt = ""
    var updatedAt = ""
    var urlArticle = ""
    var img = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        

        
        //lbl_ID.text = id
        lbl_Title.text = titleArticle
        lbl_Summary.text = Summary
        lbl_newsSite.text = newsSite
        //lbl_publishedAt.text = publishedAt
        lbl_date.text = updatedAt
        //lbl_urlArticle.text = urlArticle

        AF.request(img).responseImage(completionHandler: { [self] (response) in
                   print(response)
                   if case .success(let imageView) = response.result {
                       image.image = imageView
                   }
                   })
    }
}
