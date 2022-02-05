//
//  ReportDetailViewController.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 05/02/2022.
//

import UIKit
import Alamofire
import AlamofireImage
import FirebaseDatabase


class ReportDetailViewController: UIViewController {
    
    private let cacheManager = CacheManager()
    var preferences : Preferences = Preferences()
    
    let uID = UIDevice.current.identifierForVendor!.uuidString
    
    var launches = [Launch]()
    
    //@IBOutlet weak var lbl_ID: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Summary: UILabel!
    @IBOutlet weak var lbl_newsSite: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var img_heart: UIImageView!
    
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
    var url = URL(string: "")
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        //navbar
        self.title = "Report Details"
        
        
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
    
    //share social media
    @IBAction func onShareTapped(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: ["Check out this report from SpaceFlight News:", url as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    //qr code item click
    @IBAction func onQRCodeTapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "QRCodeStoryboard") as? QRCodeViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            vc.urlQRCode = url
        }
    }
}

