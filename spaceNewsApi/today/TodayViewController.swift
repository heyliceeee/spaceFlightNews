//
//  TodayViewController.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fetchedArticle = [Article]()
    
    @IBOutlet weak var ArticlesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ArticlesTableView.delegate = self
        ArticlesTableView.dataSource = self
        //ArticlesTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        parseData()
    }
    
    //---------------- API ----------------//
    
    func parseData(){

        fetchedArticle = []

        let url = "https://api.spaceflightnewsapi.net/v3/articles"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)

        let task = session.dataTask(with: request) { (data, response, error) in

            if(error != nil){
                print("error")

            } else {
                do {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSArray

                    for eachFetchedArticle in fetchedData {

                        let eachArticle = eachFetchedArticle as! [String: Any]

                        let idArticle = eachArticle["id"] as! Int
                        let titleArticle = eachArticle["title"] as! String
                        //let urlArticle = eachArticle["url"] as! URL
                        let imageUrlArticle = eachArticle["imageUrl"] as! String
                        //let imageArticle = eachArticle["imageUrl"] as! UIImage
                        let newsSiteArticle = eachArticle["newsSite"] as! String
                        //let summaryArticle = eachArticle["summary"] as! String
                        let publishedAtArticle = eachArticle["publishedAt"] as! String
                        let updatedAtArticle = eachArticle["updatedAt"] as! String
                        let featuredArticle = eachArticle["featured"] as! Bool
                        //let launchesArticle = eachArticle["launches"] as! Array<String>
                        //let eventsArticle = eachArticle["events"] as! Array<String>


                        self.fetchedArticle.append(Article(id: idArticle, title: titleArticle, imageUrl: imageUrlArticle, newsSite: newsSiteArticle, publishedAt: publishedAtArticle, updatedAt: updatedAtArticle, featured: featuredArticle))
                    }

                    print(self.fetchedArticle)

                }
                catch {
                    print("error 2")
                }
            }
        }
        task.resume()
    }



 class Article {

     var id: Int?
     var title: String?
     //var url: URL?
     var imageUrl: String?
     //var image: UIImage?
     var newsSite: String?
     //var summary: String?
     var publishedAt: String?
     var updatedAt: String?
     var featured: Bool?
     var launches: String?
     var events: String?


     init(id: Int, title: String, imageUrl: String, newsSite: String, publishedAt: String, updatedAt: String, featured: Bool){

         self.id = id
         self.title = title
         //self.url = url
         
         self.imageUrl = imageUrl
         //let IMAGEMFUNCIONA = try! Data(contentsOf: URL(string: imageUrl)!)
         //self.image = UIImage(data: IMAGEMFUNCIONA)
         
         self.newsSite = newsSite
         self.publishedAt = publishedAt
         self.updatedAt = updatedAt
         self.featured = featured
     }
}
    //---------------- FIM API ----------------//
    
    
    //num de linhas maybe
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //num de rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedArticle.count
    }
    
    
    //----- CONVERT URL TO IMAGEVIEW -----//
    //let a = URL(string: imageUrlString)!
    //let b = try! Data(contentsOf: a)
    
    
    func downloadImageFromUrl(urlImage: String, completion: @escaping (_ success: UIImage) -> Void){
        
        let url = URL(string: urlImage)
        
        let task = URLSession.shared.dataTask(with: url!){data, response, error in
            guard let data = data, error == nil else {return}
            
            completion(UIImage(data: data)!)
        }
        task.resume()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        //backgroundColor da cell
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        //image API
        self.downloadImageFromUrl(urlImage: fetchedArticle[indexPath.row].imageUrl as! String, completion: {image in
            
            DispatchQueue.main.sync {
                cell.imageCell.image = image
            }
        })
        //cell.imageCell.image = fetchedArticle[indexPath.row].image
        
        //print("teste: ", fetchedArticle[indexPath.row].imageUrl)
        
        //cell.imageCell.backgroundColor = .systemGray
        
        
        
        //title API
        cell.titleCell?.text = fetchedArticle[indexPath.row].title

        //newsSite API
        cell.newsSiteCell.text = fetchedArticle[indexPath.row].newsSite
        
        
        return cell
    }
}
