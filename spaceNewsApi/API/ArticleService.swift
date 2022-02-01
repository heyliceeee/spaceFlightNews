//
//  ArticleService.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import Foundation



class ArticleService {
    
    var fetchedRecentArticles = [Article]()
        
    func getRecentArticles(){
        
        fetchedRecentArticles = []
        
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
                        let summaryArticle = eachArticle["summary"] as! String
                        let publishedAtArticle = eachArticle["publishedAt"] as! String
                        let updatedAtArticle = eachArticle["updatedAt"] as! String
                        let featuredArticle = eachArticle["featured"] as! Bool
                        //let launchesArticle = eachArticle["launches"] as! Array<String>
                        //let eventsArticle = eachArticle["events"] as! Array<String>


                        self.fetchedRecentArticles.append(Article(id: idArticle, title: titleArticle, imageUrl: imageUrlArticle, newsSite: newsSiteArticle, summary: summaryArticle, publishedAt: publishedAtArticle, updatedAt: updatedAtArticle, featured: featuredArticle))
                    }

                    print(self.fetchedRecentArticles)

                }
                catch {
                    print("error 2")
                }
            }
        }
        task.resume()
    }

}
