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
            
            let urldb = value["url"] as? String
            let titledb = value["title"] as? String
            let imagedb = value["image"] as? String
            let newssitedb = value["newsSite"] as? String
            let summarydb = value["summary"] as? String
                
            let favorite = Favorite(id: ID, url: urldb, title: titledb, image: imagedb, newsSite: newssitedb, summary: summarydb)
                
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
        
        let favorite = favorites[indexPath.row]

        if let vc = storyboard?.instantiateViewController(identifier: "FavoriteDetailStoryboard") as? FavoriteDetailViewController{

            self.navigationController?.pushViewController(vc, animated: true)

            vc.id = favorite.id ?? "" //id
            vc.titleArticle = favorite.title ?? "" //title
            vc.Summary = favorite.summary ?? "" //summary
            vc.newsSite = favorite.newsSite ?? ""
            vc.url = favorite.url ?? ""

            
            if let imageUrl = favorite.image {

                vc.img = imageUrl
            }
        }
    }
}
