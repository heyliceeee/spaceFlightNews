//
//  ArticleService.swift
//  spaceNewsApi
//
//  Created by Alice Dias on 29/12/2021.
//

import Foundation
import Alamofire


class ArticleService {
    
    fileprivate var baseURL = ""
    let cacheManager = CacheManager()
    
    typealias articlesCallBack = (_ articles:[Article]?, _ status: Bool, _ message: String) -> Void
    var callBack:articlesCallBack?
    
    init(baseURL: String){
        
        self.baseURL = baseURL
    }
        
    func getRecentArticles(endPoint: String){
        
        AF.request(self.baseURL + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            
            guard let data = responseData.data else {
                
                self.callBack?(nil, false, "")

                return }
            
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                self.callBack?(articles, true, "")
            
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func getSearch(endPoint: String, search: String){
        
        AF.request(self.baseURL + endPoint, method: .get, parameters: ["title_contains": search], encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            
            guard let data = responseData.data else {
                
                self.callBack?(nil, false, "")

                return }
            
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                self.callBack?(articles, true, "")
            
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    
    func completionHandler(callBack: @escaping articlesCallBack){
        
        self.callBack = callBack
    }
}
