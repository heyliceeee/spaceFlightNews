//
//  TodayViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var apiService = ArticleService()
    //var fetchedRecentArticles = [Article]()
    
    @IBOutlet weak var ArticlesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navbar title
        self.title = "Home"
        
        ArticlesTableView.delegate = self
        ArticlesTableView.dataSource = self
        //ArticlesTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        apiService.getRecentArticles() //mostra todos os artigos
    }
    
    //---------------- API ----------------//
    
//    func parseData(){
//
//        fetchedArticle = []
//
//        let url = "https://api.spaceflightnewsapi.net/v3/articles"
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "GET"
//
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//
//            if(error != nil){
//                print("error")
//
//            } else {
//                do {
//                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSArray
//
//                    for eachFetchedArticle in fetchedData {
//
//                        let eachArticle = eachFetchedArticle as! [String: Any]
//
//                        let idArticle = eachArticle["id"] as! Int
//                        let titleArticle = eachArticle["title"] as! String
//                        //let urlArticle = eachArticle["url"] as! URL
//                        let imageUrlArticle = eachArticle["imageUrl"] as! String
//                        //let imageArticle = eachArticle["imageUrl"] as! UIImage
//                        let newsSiteArticle = eachArticle["newsSite"] as! String
//                        let summaryArticle = eachArticle["summary"] as! String
//                        let publishedAtArticle = eachArticle["publishedAt"] as! String
//                        let updatedAtArticle = eachArticle["updatedAt"] as! String
//                        let featuredArticle = eachArticle["featured"] as! Bool
//                        //let launchesArticle = eachArticle["launches"] as! Array<String>
//                        //let eventsArticle = eachArticle["events"] as! Array<String>
//
//
//                        self.fetchedArticle.append(Article(id: idArticle, title: titleArticle, imageUrl: imageUrlArticle, newsSite: newsSiteArticle, summary: summaryArticle, publishedAt: publishedAtArticle, updatedAt: updatedAtArticle, featured: featuredArticle))
//                    }
//
//                    print(self.fetchedArticle)
//
//                }
//                catch {
//                    print("error 2")
//                }
//            }
//        }
//        task.resume()
//    }



// class Article {
//
//     var id: Int?
//     var title: String?
//     //var url: URL?
//     var imageUrl: String?
//     var newsSite: String?
//     var summary: String?
//     var publishedAt: String?
//     var updatedAt: String?
//     var featured: Bool?
//     var launches: String?
//     var events: String?
//
//
//     init(id: Int, title: String, imageUrl: String, newsSite: String, summary: String, publishedAt: String, updatedAt: String, featured: Bool){
//
//         self.id = id
//         self.title = title
//         //self.url = url
//
//         self.imageUrl = imageUrl
//         self.summary = summary
//         self.newsSite = newsSite
//         self.publishedAt = publishedAt
//         self.updatedAt = updatedAt
//         self.featured = featured
//     }
//}
    //---------------- FIM API ----------------//
    
    
    //num de sections
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //num de rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return apiService.fetchedRecentArticles.count
    }
    
    
    //----- CONVERT URL TO IMAGEVIEW -----//
    func downloadImageFromUrl(urlImage: String, completion: @escaping (_ success: UIImage) -> Void){
        
        let url = URL(string: urlImage)
        
        let task = URLSession.shared.dataTask(with: url!){data, response, error in
            guard let data = data, error == nil else {return}
            
            completion(UIImage(data: data)!)
        }
        task.resume()
    }
    
    
    
    
    //O QUE A CELL MOSTRA
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        //backgroundColor da cell
        //cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        //image Articles list
        self.downloadImageFromUrl(urlImage: apiService.fetchedRecentArticles[indexPath.row].imageUrl as! String, completion: {image in
            
            DispatchQueue.main.sync {
                cell.imageCell.image = image
            }
        })
        
        //title Articles list
        cell.titleCell?.text = apiService.fetchedRecentArticles[indexPath.row].title

        //newsSite Articles list
        cell.newsSiteCell.text = apiService.fetchedRecentArticles[indexPath.row].newsSite
        
        //Remove Cell Selection Backgound
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    
    //AO SELECIONAR UMA CELL - article details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let articlesID = apiService.fetchedRecentArticles[indexPath.row].id
        let idconvert = "\(articlesID ?? 0)" //convert int to string
        
        let articlesTitle = apiService.fetchedRecentArticles[indexPath.row].title

        
        if let vc = storyboard?.instantiateViewController(identifier: "ArticleDetailsStoryboard") as? ArticleDetailsViewController{
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            vc.id = idconvert //id
            vc.titleArticle = apiService.fetchedRecentArticles[indexPath.row].title ?? "" //title
            //vc.newsSite = fetchedArticle[indexPath.row].newsSite ?? ""
            //vc.publishedAt = fetchedArticle[indexPath.row].publishedAt ?? ""
            //vc.updatedAt = fetchedArticle[indexPath.row].updatedAt ?? ""
            //vc.urlArticle = fetchedArticle[indexPath.row].urlArticle ?? ""
            
            //image
            //let url = URL(string: fetchedArticle[indexPath])
            self.downloadImageFromUrl(urlImage: apiService.fetchedRecentArticles[indexPath.row].imageUrl as! String, completion: {image in

                vc.img = image
            })
        }
    }
}


