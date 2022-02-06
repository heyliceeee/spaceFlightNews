//
//  ReportService.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 05/02/2022.
//

import Foundation
import Alamofire

class ReportService {
    
    fileprivate var baseURL = ""
    let cacheManager = CacheManager()
    
    typealias reportCallBack = (_ report:[Report]?, _ status: Bool, _ message: String) -> Void
    var callBack:reportCallBack?
    
    init(baseURL: String){
        
        self.baseURL = baseURL
    }
        
    func getRecentReport(endPoint: String){
        
        AF.request(self.baseURL + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            
            guard let data = responseData.data else {
                
                self.callBack?(nil, false, "")

                return }
            
            do {
                let reports = try JSONDecoder().decode([Report].self, from: data)
                self.callBack?(reports, true, "")
            
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callBack: @escaping reportCallBack){
        
        self.callBack = callBack
    }
}
