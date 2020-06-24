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
        let header = ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc3Vwcy5relwvYXBpXC92MVwvcmVnaXN0ZXIiLCJpYXQiOjE1OTMwMjYwNjIsImV4cCI6MTU5MzI0MjA2MiwibmJmIjoxNTkzMDI2MDYyLCJqdGkiOiJ0STFoV25STUxsdVI0M3JpIiwic3ViIjoxNSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.wmzM3Bbvl97smryPEnSSj-q1V-bqN-IWJCFEQVHE0E4"]

           Alamofire.request(Constants.shared().baseUrl + "news?=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
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
