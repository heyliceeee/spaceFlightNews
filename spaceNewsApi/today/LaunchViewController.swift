//
//  LaunchViewController.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 03/02/2022.
//

import UIKit
import Alamofire
import AlamofireImage

class LaunchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var launches = [Launch]()
    
    var launchId = ""
    
    @IBOutlet weak var LaunchesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LaunchesTableView.dataSource = self
        LaunchesTableView.delegate = self
        
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
}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(launches.count)
        return launches.count
    }
    
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
