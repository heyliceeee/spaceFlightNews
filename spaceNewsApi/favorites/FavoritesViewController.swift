//
//  FavoritesViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 05/02/2022.
//

import UIKit
import FirebaseDatabase
import Alamofire

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //get uid
    let uID = UIDevice.current.identifierForVendor!.uuidString
    var favorites = [Favorite]()
    
    @IBOutlet weak var FavoritesTableView: UITableView! {
        
        didSet{
            FavoritesTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navbar title
        self.title = "Favorites"
        
        
        FavoritesTableView.delegate = self
        FavoritesTableView.dataSource = self
        
        
        //open db firebase
        let ref = Database.database(url: "https://spaceflightnews-c5209-default-rtdb.europe-west1.firebasedatabase.app").reference()
        
        //read favorites from db
        ref.child("favorites").child(self.uID).observe(.childAdded, with: { (snapshot) in

            let ID = snapshot.key as String //get autoID
            let value = snapshot.value as! [String:Any]
            
            let titledb = value["title"] as? String
            let imagedb = value["image"] as? String
            let newssitedb = value["newsSite"] as? String
            let summarydb = value["summary"] as? String
                
            let favorite = Favorite(id: ID, title: titledb, image: imagedb, newsSite: newssitedb, summary: summarydb)
                
                self.favorites.append(favorite)
                
                
                let row = self.favorites.count
                
                if ((row) != 0) {
                    
                    let indexPath = IndexPath(row: row-1, section: 0)
                    self.FavoritesTableView.insertRows(at: [indexPath], with: .automatic)
                }
        })
    }
    
    
    //num de sections
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    
    //num de rows por sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorites.count
    }
    
    
    //O QUE A CELL MOSTRA
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoritesTableViewCell
        
        
        let favorite = favorites[indexPath.row]
 
        
        //image Articles list
        if let imageUrl = favorite.image {
            AF.request(imageUrl).responseImage(completionHandler: { (response) in
               print(response)

               if case .success(let image) = response.result {
                   cell.imageCell?.image = image
               }
               })
        }

        
        //newsSite Articles list
        cell.titleCell?.text = favorite.title

        //newsSite Articles list
        cell.newsSiteCell?.text = favorite.newsSite

        //remove Cell Selection Backgound
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }


    //AO SELECIONAR UMA CELL - article details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
//        let article = articles[indexPath.row]
//
//        let articlesID = article.id
//        let idconvert = "\(articlesID ?? 0)" //convert int to string
//
//        if let vc = storyboard?.instantiateViewController(identifier: "ArticleDetailsStoryboard") as? ArticleDetailsViewController{
//
//            self.navigationController?.pushViewController(vc, animated: true)
//
//            vc.id = idconvert //id
//            vc.titleArticle = article.title ?? "" //title
//            vc.Summary = article.summary ?? "" //summary
//            vc.newsSite = article.newsSite ?? ""
//            vc.url = article.url
//
//            if let imageUrl = article.imageUrl {
//
//                vc.img = imageUrl
//            }
//
//            //date
//            let articleUpdatedAt = article.publishedAt ?? ""
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//
//            let theDate = dateFormatter.date(from: articleUpdatedAt)!
//
//            //date updatedAt
//            let newDateFormatter = DateFormatter()
//            newDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//            let dateconvertString = newDateFormatter.string(from: theDate)
//            let dateconvert = newDateFormatter.date(from: dateconvertString)
//
//
//            //date current
//            let date = Date()
//            let df = DateFormatter()
//            df.dateFormat = "yyyy-MM-dd HH:mm"
//            let datecurrentString = df.string(from: date)
//            let datecurrent = df.date(from: datecurrentString)
//
//            //difference between date updatedAt and date current
//            let timeInterval = (datecurrent?.timeIntervalSince(dateconvert!))//seconds
//
//            //convert timeInterval (double) to int
//            let timeIntervalInt = Int(timeInterval!) //seconds
//
//            //verify date and return
//            if timeIntervalInt >= 0 && timeIntervalInt < 60 {
//
//                vc.updatedAt = "\(timeIntervalInt) seconds ago"
//
//
//            } else if timeIntervalInt >= 60 && timeIntervalInt < 3600 {
//
//                let timeMinutes = ((timeIntervalInt % 3600) / 60) //minutes
//                vc.updatedAt = "\(timeMinutes) minutes ago"
//
//
//            } else if timeIntervalInt >= 3600 && timeIntervalInt < 7200 {
//
//                let timeHour = ((timeIntervalInt % 86400) / 3600) //hour
//                vc.updatedAt = "\(timeHour) hour ago"
//
//
//            } else if timeIntervalInt >= 7200 && timeIntervalInt < 86400 {
//
//                let timeHours = ((timeIntervalInt % 86400) / 3600) //hours
//                vc.updatedAt = "\(timeHours) hours ago"
//
//
//            } else if timeIntervalInt >= 86400  && timeIntervalInt < 172800 {
//
//                let timeDay = ((timeIntervalInt / 86400)) //day
//                vc.updatedAt = "\(timeDay) day ago"
//
//
//            } else if timeIntervalInt >= 172800 {
//
//                let timeDays = ((timeIntervalInt / 86400)) //days
//                vc.updatedAt = "\(timeDays) days ago"
//            }
//        }
    }
}
