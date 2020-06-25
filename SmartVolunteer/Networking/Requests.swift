//
//  Requests.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/21/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class Requests: NSObject {
    
    private static var sharedReference : Requests{
          let headers = Requests()
          return headers
    }
    
    class func shared() -> Requests {
          return sharedReference
    }
    
    func checkLogin(params : [String: AnyObject], callback: @escaping (CheckLoginResponse?) -> ()) {
        Alamofire.request(Constants.shared().baseUrl + "login/check", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<CheckLoginResponse>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
                }
            }
    }
    func getCities(callback: @escaping (CitiesResponse?) -> ()) {
        Alamofire.request(Constants.shared().baseUrl + "cities", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<CitiesResponse>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
                }
            }
    }
    func register(params : [String: AnyObject], callback: @escaping (RegisterResponse?) -> ()) {
        Alamofire.request(Constants.shared().baseUrl + "register", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<RegisterResponse>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
                }
            }
    }
    
    func logIn(params : [String: AnyObject], callback: @escaping (RegisterResponse?) -> ()) {
        Alamofire.request(Constants.shared().baseUrl + "login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<RegisterResponse>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
                }
            }
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

    public func getFunds(page: Int, callback: @escaping (FundsResponse) -> ()){
        Alamofire.request(Constants.shared().baseUrl + "funds?=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.shared().getHeaders()).responseObject{
               (response: DataResponse<FundsResponse>) in
               if let statusCode = response.response?.statusCode, statusCode == 401 {
                   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unauthorized"), object: nil)
                   return
               }
            
               if let _ = response.response{
                   let model  = response.result
                print("get funds \(model.value!)")
                   if model.value != nil {
                       callback(model.value!)
                   }
               }
           }
       }
    
    func subscribe(id : Int, callback: @escaping (StandartResponse?) -> ()) {
        Alamofire.request(Constants.shared().baseUrl + "fund/subscribe/\(id)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: Constants.shared().getHeaders()).responseObject{
               (response: DataResponse<StandartResponse>) in
               if let _ = response.response{
                   let model = response.result
                   callback(model.value ?? nil)
                   }
               }
       }

}
