//
//  TodayViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import UIKit

class TodayViewController: UIViewController //,UITableViewDelegate, UITableViewDataSource
{

    
    
    @IBOutlet weak var ArticlesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navbar title
        self.title = "Home"
        
        //ArticlesTableView.delegate = self
        //ArticlesTableView.dataSource = self
        
        let apiService = ArticleService(baseURL: "https://api.spaceflightnewsapi.net/v3")
        apiService.getRecentArticles(endPoint: "/articles")
        //ArticlesTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        //apiService.getRecentArticles() //mostra todos os artigos
    }
    
    
    //num de sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 1
//    }
    
    
    //num de rows
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return 8 //apiService.fetchedRecentArticles.count
//    }
    
    
    //----- CONVERT URL TO IMAGEVIEW -----//
//    func downloadImageFromUrl(urlImage: String, completion: @escaping (_ success: UIImage) -> Void){
//
//        let url = URL(string: urlImage)
//
//        let task = URLSession.shared.dataTask(with: url!){data, response, error in
//            guard let data = data, error == nil else {return}
//
//            completion(UIImage(data: data)!)
//        }
//        task.resume()
//    }
    
    
    
    //O QUE A CELL MOSTRA
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
//
//        //backgroundColor da cell
//        //cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
//
//        //image Articles list
//        self.downloadImageFromUrl(urlImage: apiService.fetchedRecentArticles[indexPath.row].imageUrl as! String, completion: {image in
//
//            DispatchQueue.main.sync {
//                cell.imageCell.image = image
//            }
//        })
//
//        //title Articles list
//        cell.titleCell?.text = apiService.fetchedRecentArticles[indexPath.row].title
//
//        //newsSite Articles list
//        cell.newsSiteCell.text = apiService.fetchedRecentArticles[indexPath.row].newsSite
//
//        //Remove Cell Selection Backgound
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//
//        return cell
//    }
//
//
//    //AO SELECIONAR UMA CELL - article details
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//
//        let articlesID = apiService.fetchedRecentArticles[indexPath.row].id
//        let idconvert = "\(articlesID ?? 0)" //convert int to string
//
//        let articlesTitle = apiService.fetchedRecentArticles[indexPath.row].title
//
//
//        if let vc = storyboard?.instantiateViewController(identifier: "ArticleDetailsStoryboard") as? ArticleDetailsViewController{
//
//            self.navigationController?.pushViewController(vc, animated: true)
//
//            vc.id = idconvert //id
//            vc.titleArticle = apiService.fetchedRecentArticles[indexPath.row].title ?? "" //title
//            //vc.newsSite = fetchedArticle[indexPath.row].newsSite ?? ""
//            //vc.publishedAt = fetchedArticle[indexPath.row].publishedAt ?? ""
//            //vc.updatedAt = fetchedArticle[indexPath.row].updatedAt ?? ""
//            //vc.urlArticle = fetchedArticle[indexPath.row].urlArticle ?? ""
//
//            //image
//            //let url = URL(string: fetchedArticle[indexPath])
//            self.downloadImageFromUrl(urlImage: apiService.fetchedRecentArticles[indexPath.row].imageUrl as! String, completion: {image in
//
//                vc.img = image
//            })
//        }
//    }
}


