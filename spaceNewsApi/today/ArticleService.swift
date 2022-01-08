//
//  ArticleService.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import Foundation

class ArticleService {
        
    let API_URL = "https://api.spaceflightnewsapi.net/v3"
        
    
    func fetch() {
        
        let urlString = API_URL + "/articles"
        
        if let url = URL.init(string: urlString){
            
            let task = URLSession.shared.dataTask(
                with: url,
                completionHandler: {(data, response, error) in
                
                //handle data or error
                print(String.init(data: data!, encoding: .ascii) ?? "no data")
                
                //handle JSON decoding
                if let article = try? JSONDecoder().decode(Article.self, from: data!){
                    print(article.launches ?? "no launches")
                    print(article.events ?? "no events")
                }
            })
            task.resume()
        }
    }
}
