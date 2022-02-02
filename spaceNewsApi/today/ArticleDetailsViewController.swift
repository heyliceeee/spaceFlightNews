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
    
    private let cacheManager = CacheManager()
    var preferences : Preferences = Preferences()
    
    var launches = [Launch]()
    
    //@IBOutlet weak var lbl_ID: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Summary: UILabel!
    @IBOutlet weak var lbl_newsSite: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    private let defaultTitleFontSize = 20.0
    
    var id = ""
    var titleArticle = ""
    var Summary = ""
    var newsSite = ""
    var publishedAt = ""
    var updatedAt = ""
    var urlArticle = ""
    var img = ""
    var launchId = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //launch
        let apiService = LaunchService(baseURL: "https://api.spaceflightnewsapi.net/v3")
        apiService.getLaunch(endPoint: "/articles/launches", id: "/\(launchId)")
        apiService.completionHandler { [weak self] (launches, status, message) in
            
            if status {
                guard let self = self else { return }
                guard let _launches = launches else { return }
                self.launches = _launches
                
            }
            
        }
        
        //Preferences
        //lbl_Title.font  = lbl_Title.font.withSize(CGFloat(preferences.getfontSize()))
        lbl_Title.font = lbl_Title.font.withSize(CGFloat(cacheManager.getCachedFontSize() ?? Float(defaultTitleFontSize)))
        
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
