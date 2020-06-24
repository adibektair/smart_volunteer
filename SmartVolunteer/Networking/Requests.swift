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

    
}
