//
//  Requests.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/21/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import Alamofire


class Requests: NSObject {
    
    private static var sharedReference : Requests{
          let headers = Requests()
          return headers
    }
    
    class func shared() -> Requests {
          return sharedReference
    }
    
    public func getNews(page: Int, callback: @escaping (News) -> ()){
        Alamofire.request(Constants.shared().baseUrl + "news?=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<News>) in
            if let statusCode = response.response?.statusCode, statusCode == 401 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unauthorized"), object: nil)
                           
                return
            }
            if let _ = response.response{
                let model  = response.result
                if model.value != nil {
                    callback(model.value!)
                }
            }
        }
    }
    
}
