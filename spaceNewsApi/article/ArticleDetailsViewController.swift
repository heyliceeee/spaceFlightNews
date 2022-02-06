//
//  ArticleDetailsViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 18/01/2022.
//

import UIKit
import Alamofire
import AlamofireImage
import FirebaseDatabase
import CloudKit
import UserNotifications


class ArticleDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    
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
    @IBOutlet weak var img_qr: UIImageView!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var img_heart: UIImageView!
    @IBOutlet weak var tf_comment: UITextField!
    //@IBOutlet weak var text_field_comment: UITextView!
    @IBOutlet weak var btn_comment: UIButton!
    @IBOutlet weak var CommentsTableView: UITableView! {
        
        didSet{
            CommentsTableView.dataSource = self
        }
    }
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
    var url = URL(string: "")
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        //navbar
        self.title = "Article Details"
        
        tf_comment.attributedPlaceholder = NSAttributedString(
            string: "Insert Comment",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2]
        )
        
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        
        //hide keyboard
        tf_comment.delegate = self
        
        
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
        
        
        //gesture tap in heart (favorite)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped(_:)))
        
        img_heart.isUserInteractionEnabled = true
        img_heart.addGestureRecognizer(tapGestureRecognizer)
        
        
        //open db firebase
        let ref = Database.database(url: "https://spaceflightnews-c5209-default-rtdb.europe-west1.firebasedatabase.app").reference()
        
        //read favorites from db
        ref.child("comments").child(self.id).observe(.childAdded, with: { (snapshot) in

            let ID = snapshot.key as String //get autoID
            let value = snapshot.value as! [String:Any]
            
            let commentdb = value["comment"] as? String
            let datedb = value["date"] as? String
            let namedb = value["name"] as? String
                
            let comment = Comment(id: ID, name: namedb, date: datedb, comment: commentdb)
                
                self.comments.append(comment)
                
                
                let row = self.comments.count
                
                if ((row) != 0) {
                    
                    let indexPath = IndexPath(row: row-1, section: 0)
                    self.CommentsTableView.insertRows(at: [indexPath], with: .automatic)
                }
        })
        
        
        //notifications - get user permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
            
            if granted {
                print("user gave permissions for local notifications")
            }
        })
    }
    
    
    //hidden keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        tf_comment.resignFirstResponder()
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
    
    
    //comment click
    @IBAction func onTappedComment(_ sender: Any) {
        
        //get username
        let urName = UIDevice.current.name
        
        //get date current
        let date = Date()
    
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
    
        let dateCurrent = formatter.string(from: date)
    
        
        tf_comment.resignFirstResponder()
        
        
        //verifica se textfield está vazio, se sim ignora, se nao
        if tf_comment.text == "" {
            
            print("vazio")
        
        
        } else if tf_comment.text != "" {

            print(tf_comment.text ?? "")
            
            //open db firebase
            let ref = Database.database(url: "https://spaceflightnews-c5209-default-rtdb.europe-west1.firebasedatabase.app").reference()
            
            //add article favorite to db
            ref.child("comments").child(self.id).childByAutoId().setValue([
                "name": urName,
                "comment": tf_comment.text ?? "",
                "date": dateCurrent
            ])
            
            
            print("nao esta vazio")
            
            
            //notifications
            let center = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            content.title = "New Comment"
            content.body = "You added a new comment to an Article"
            content.sound = .default
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            let request = UNNotificationRequest(identifier: "comment", content: content, trigger: trigger)
            
            center.delegate = self
            
            center.add(request, withCompletionHandler: nil)
        }
        
        tf_comment.text = ""
    }
    
    
    //favorite click
    @objc func favoriteTapped(_ sender: AnyObject){
        
        var refreshAlert = UIAlertController(title: "Add Favorites", message: "Do you want add this article your favorites?", preferredStyle: UIAlertController.Style.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            //open db firebase
            let ref = Database.database(url: "https://spaceflightnews-c5209-default-rtdb.europe-west1.firebasedatabase.app").reference()
            
            //add article favorite to db
            ref.child("favorites").child(self.uID).childByAutoId().setValue([
                "id": self.id,
                "url": self.url?.absoluteString,
                "image": self.img,
                "title": self.titleArticle,
                "summary": self.Summary,
                "newsSite": self.newsSite
            ])
            
            
            print("add db")
            
            
            //notifications
            let center = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            content.title = "Favories"
            content.body = "You've added a new article to your Favorites"
            content.sound = .default
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: "favorite", content: content, trigger: trigger)
            
            center.add(request){ (error) in
                
                if error != nil {
                    
                    print("error: \(error?.localizedDescription ?? "error local notification")")
                }
            }
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            print("press cancel")
        }))
        
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    //share social media
    @IBAction func onShareTapped(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: ["Check out this article from SpaceFlight News:", url as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    //qr code item click
    @IBAction func onQRCodeTapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "QRCodeStoryboard") as? QRCodeViewController {
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            vc.urlQRCode = url
        }
    }
    
    
    //notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound, .badge])
    }
}
