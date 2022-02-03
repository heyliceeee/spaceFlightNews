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
    @IBOutlet weak var LaunchesTableView: UITableView!
    
    @IBOutlet weak var teste_lbl: UILabel!
    
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
        
        
        
        
        print("id: \(launchId)")
        //launch
        let apiService = LaunchService(baseURL: "https://api.spaceflightnewsapi.net/v3")
        apiService.getLaunch(endPoint: "/articles/launch", id: "/\(launchId)")
        apiService.completionHandler { [weak self] (launches, status, message) in
            
            if status {
                guard let self = self else { return }
                guard let _launches = launches else { return }
                self.launches = _launches
                self.LaunchesTableView.reloadData()
            }
            
        }
        
        //teste_lbl.text = "\(launches.id)"
        
        //Preferences
        //lbl_Title.font  = lbl_Title.font.withSize(CGFloat(preferences.getfontSize()))
        lbl_Title.font = lbl_Title.font.withSize(CGFloat(cacheManager.getCachedFontSize() ?? Float(defaultTitleFontSize)))
        

        lbl_Title.text = titleArticle
        lbl_Summary.text = Summary
        lbl_newsSite.text = newsSite
        lbl_date.text = updatedAt

        AF.request(img).responseImage(completionHandler: { [self] (response) in
            
            print(response)
            
            if case .success(let imageView) = response.result {
                image.image = imageView
            }
        })
    }
    
    //num de sections
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    @IBAction func btn_launch(_ sender: Any) {
        let sb = storyboard?.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
        
        sb.launchId = launchId
    }
    
    //num de rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(launches.count)
        return launches.count
    }
    
    //O QUE A CELL MOSTRA
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchesTableViewCell

        let launch = launches[indexPath.row]
        
        //image Articles list
        if let imageUrl = launch.imageUrl {
            AF.request(imageUrl).responseImage(completionHandler: { (response) in
               print(response)
               
               if case .success(let image) = response.result {
                   cell.imageLaunchCell.image = image
               }
               
               })
        }
        
        //title Articles list
        cell.titleCell?.text = launch.title

        //newsSite Articles list
        cell.newsSiteCell.text = launch.newsSite

        //remove Cell Selection Backgound
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
}
