//
//  TodayViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import UIKit
import Alamofire
import AlamofireImage

class TodayViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var ArticlesTableView: UITableView!
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navbar title
        self.title = "Home"
        
        ArticlesTableView.delegate = self
        ArticlesTableView.dataSource = self
        
        let apiService = ArticleService(baseURL: "https://api.spaceflightnewsapi.net/v3")
        apiService.getRecentArticles(endPoint: "/articles")
        apiService.completionHandler { [weak self] (articles, status, message) in
            
            if status {
                guard let self = self else { return }
                guard let _articles = articles else { return }
                self.articles = _articles
                self.ArticlesTableView.reloadData()
            }
        }
    }
    
    
    //num de sections
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    
    //num de rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articles.count
    }
    
    
    //O QUE A CELL MOSTRA
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell

        let article = articles[indexPath.row]
        
        //image Articles list
        if let imageUrl = article.imageUrl {
            AF.request(imageUrl).responseImage(completionHandler: { (response) in
               print(response)
               
               if case .success(let image) = response.result {
                   cell.imageCell.image = image
               }
               
               })
        }
        
        //title Articles list
        cell.titleCell?.text = article.title

        //newsSite Articles list
        cell.newsSiteCell.text = article.newsSite

        //remove Cell Selection Backgound
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }


    //AO SELECIONAR UMA CELL - article details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let article = articles[indexPath.row]

        let articlesID = article.id
        let idconvert = "\(articlesID ?? 0)" //convert int to string
        
        if let vc = storyboard?.instantiateViewController(identifier: "ArticleDetailsStoryboard") as? ArticleDetailsViewController{

            self.navigationController?.pushViewController(vc, animated: true)

            vc.id = idconvert //id
            vc.titleArticle = article.title ?? "" //title
            vc.Summary = article.summary ?? "" //summary
            vc.newsSite = article.newsSite ?? ""
            
            if let imageUrl = article.imageUrl {
                
                vc.img = imageUrl
            }
            
            //date
            let articleUpdatedAt = article.publishedAt ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            
            let theDate = dateFormatter.date(from: articleUpdatedAt)!
            
            //date updatedAt
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateconvertString = newDateFormatter.string(from: theDate)
            let dateconvert = newDateFormatter.date(from: dateconvertString)
            
            
            print("HORA DO ARITGO: ", dateconvertString)
            
            
            
            
            //date current
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm"
            let datecurrentString = df.string(from: date)
            let datecurrent = df.date(from: datecurrentString)
            
            //difference between date updatedAt and date current
            let timeInterval = (datecurrent?.timeIntervalSince(dateconvert!))//seconds
            
            //convert timeInterval (double) to int
            let timeIntervalInt = Int(timeInterval!) //seconds
            print("SEGUNDOS DIFERENÇA: ", timeIntervalInt)
            
            
            if timeIntervalInt >= 0 && timeIntervalInt < 60 {
                
                vc.updatedAt = "\(timeIntervalInt) seconds ago"
            
                
            } else if timeIntervalInt >= 60 && timeIntervalInt < 3600 {
            
                let timeMinutes = ((timeIntervalInt % 3600) / 60) //minutes
                vc.updatedAt = "\(timeMinutes) minutes ago"
            
                
            } else if timeIntervalInt >= 3600 && timeIntervalInt < 7200 {
                
                let timeHour = ((timeIntervalInt % 86400) / 3600) //hour
                vc.updatedAt = "\(timeHour) hour ago"
            
                
            } else if timeIntervalInt >= 7200 && timeIntervalInt < 86400 {
                
                let timeHours = ((timeIntervalInt % 86400) / 3600) //hours
                vc.updatedAt = "\(timeHours) hours ago"
            
                
            } else if timeIntervalInt >= 86400  && timeIntervalInt < 172800 {
                
                let timeDay = ((timeIntervalInt / 86400)) //day
                vc.updatedAt = "\(timeDay) day ago"
            
            
            } else if timeIntervalInt >= 172800 {
                
                let timeDays = ((timeIntervalInt / 86400)) //days
                vc.updatedAt = "\(timeDays) days ago"
            }
        }
    }
}


