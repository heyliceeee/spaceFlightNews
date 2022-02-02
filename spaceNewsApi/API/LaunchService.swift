//
//  LaunchService.swift
//  spaceNewsApi
//
//  Created by Tiago Costa on 02/02/2022.
//

import Foundation
import Alamofire

class LaunchService {
    
    fileprivate var baseURL = ""
    
    typealias launchesCallBack = (_ launches:[Launch]?, _ status:Bool, _ message: String) -> Void
    var callBack:launchesCallBack?
    
    init(baseURL: String){
        self.baseURL = baseURL
    }
    
    func getLaunch(endPoint: String, id: String){
        
        AF.request(self.baseURL + endPoint + id, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                
                return }
            
            do {
                let launches = try JSONDecoder().decode([Launch].self, from: data)
                self.callBack?(launches, true, "")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callBack: @escaping launchesCallBack){
        
        self.callBack = callBack
    }
}
