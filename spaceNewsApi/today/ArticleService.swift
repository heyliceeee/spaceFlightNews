//
//  ArticleService.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import Foundation

class ArticleService {
    
    class func listArticles(completion: @escaping (Article) -> Void){
        
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    
                    guard let data = data else { return }
                    
                } else {
                    print("status invalid, status code: \(response.statusCode)")
                }
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
    }
}
