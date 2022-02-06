//
//  ArticleDetailsViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 06/02/2022.
//

import UIKit
import Alamofire
import AlamofireImage
import FirebaseDatabase
import CloudKit
import UserNotifications


class FavoriteDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    
    private let cacheManager = CacheManager()
    var preferences : Preferences = Preferences()
    
    let uID = UIDevice.current.identifierForVendor!.uuidString
    
    var launches = [Launch]()
    
    
    var comments = [Comment]()
    
    
    //@IBOutlet weak var lbl_ID: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Summary: UILabel!
    @IBOutlet weak var lbl_newsSite: UILabel!
    //@IBOutlet weak var img_qr: UIImageView!
    //@IBOutlet weak var lbl_date: UILabel!
    //@IBOutlet weak var img_heart: UIImageView!
    //@IBOutlet weak var tf_comment: UITextField!
    //@IBOutlet weak var text_field_comment: UITextView!
    //@IBOutlet weak var btn_comment: UIButton!
//    @IBOutlet weak var CommentsTableView: UITableView! {
//
//        didSet{
//            CommentsTableView.dataSource = self
//        }
//    }
    //@IBOutlet weak var txt_field_comment: UITextView!
    
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
    var url = ""
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        //navbar
        self.title = "Favorite Details"
        
        print(url)
        
        
        //Preferences
        //lbl_Title.font  = lbl_Title.font.withSize(CGFloat(preferences.getfontSize()))
        lbl_Title.font = lbl_Title.font.withSize(CGFloat(cacheManager.getCachedFontSize() ?? Float(defaultTitleFontSize)))
        
        //lbl_ID.text = id
        lbl_Title.text = titleArticle
        lbl_Summary.text = Summary
        lbl_newsSite.text = newsSite
        //lbl_publishedAt.text = publishedAt
        //lbl_date.text = updatedAt
        //lbl_urlArticle.text = urlArticle

        AF.request(img).responseImage(completionHandler: { [self] (response) in
            
            print(response)
            
            if case .success(let imageView) = response.result {
                image.image = imageView
            }
        })
        
        
        
        //notifications - get user permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
            
            if granted {
                print("user gave permissions for local notifications")
            }
        })
    }
    
    
    
    //num de sections
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
        
        
    //num de rows por sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentsTableViewCell
            
            
        let comment = comments[indexPath.row]
     
            
        //name Comments list
        cell.nameCell?.text = comment.name

        //date Comments list
        cell.dateCell?.text = comment.date
            
        //comment Comments list
        cell.commentCell?.text = comment.comment

        //remove Cell Selection Backgound
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    
    
    
    //share social media
    @IBAction func onShareTapped(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: ["Check out this article from SpaceFlight News:", URL(string: "\(url)") as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    //qr code item click
    @IBAction func onQRCodeTapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "QRCodeStoryboard") as? QRCodeViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            vc.urlQRCode = URL(string: "\(url)")
        }
    }
    
    
    //notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound, .badge])
    }
}
