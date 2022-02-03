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
    @IBOutlet weak var img_qr: UIImageView!
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
    var url = URL(string: "")
    var imgQR = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
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
        
        
        //qr code
        func generateQRCode(from string: String) -> UIImage?{
            
            let data = string.data(using: String.Encoding.ascii)
            
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                
                filter.setValue(data, forKey: "inputMessage")
                
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                
                if let output = filter.outputImage?.transformed(by: transform){
                    return UIImage(ciImage: output)
                }
            }
            
            return nil
        }
        
        let imageQR = generateQRCode(from: "\(url	)")
        
        img_qr.image = imageQR
    }
    
    
    //share social media
    @IBAction func onShareTapped(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: ["Check out this article from SpaceFlight News:", url as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}
