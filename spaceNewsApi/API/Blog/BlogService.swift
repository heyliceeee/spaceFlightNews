//
//  BlogService.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 05/02/2022.
//

import Foundation
import Alamofire

class BlogService {
    
    fileprivate var baseURL = ""
    let cacheManager = CacheManager()
    
    typealias blogCallBack = (_ blogs:[Blog]?, _ status: Bool, _ message: String) -> Void
    var callBack:blogCallBack?
    
    init(baseURL: String){
        
        self.baseURL = baseURL
    }
        
    func getRecentBlogs(endPoint: String){
        
        AF.request(self.baseURL + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            
            guard let data = responseData.data else {
                
                self.callBack?(nil, false, "")

                return }
            
            do {
                let blogs = try JSONDecoder().decode([Blog].self, from: data)
                self.callBack?(blogs, true, "")
            
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    
    func completionHandler(callBack: @escaping blogCallBack){
        
        self.callBack = callBack
    }
}
