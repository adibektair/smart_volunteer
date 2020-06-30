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
    
    public func getNews(page: Int,search: String = "", callback: @escaping (News) -> ()){
        let header = Constants.shared().getHeaders()
        Alamofire.request(Constants.shared().baseUrl + "news?page=\(page)&title=\(search.encodeUrl)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
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
    
    public func getApplications(page:Int,filter: String = "",type : String? = "",callback: @escaping (Applications) -> ()){
        let header = Constants.shared().getHeaders()
        var and = "?"
        if filter != "" || type != "" {
                and = "&"
        }
        let url = Constants.shared().baseUrl + "applications" + (type ?? "") + filter + "\(and)page=\(page)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            (response: DataResponse<Applications>) in
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
    public func getApplicationsFiltered(url:String, callback: @escaping (Applications) -> ()){
        let header = Constants.shared().getHeaders()
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            (response: DataResponse<Applications>) in
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
    
    public func getCategories( callback: @escaping (Categories) -> ()){
        let header = Constants.shared().getHeaders()
        Alamofire.request(Constants.shared().baseUrl + "categories/applications", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            (response: DataResponse<Categories>) in
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
    func getTypes(callback: @escaping (Types?) -> ()) {
        let header = Constants.shared().getHeaders()
           Alamofire.request(Constants.shared().baseUrl + "application/types", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
               (response: DataResponse<Types>) in
               if let _ = response.response{
                   let model = response.result
                   callback(model.value ?? nil)
               }
           }
       }
    func getMyApplications(page: Int,callback: @escaping (Applications?) -> ()) {
      let header = Constants.shared().getHeaders()
            Alamofire.request(Constants.shared().baseUrl + "my/applications?page=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
                (response: DataResponse<Applications>) in
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
    
    
    public func getVolunteersList(id: Int, page : Int, callback: @escaping (Volunteers) -> ()){
        Alamofire.request(Constants.shared().baseUrl + "application/volunteers/\(id)?page=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.shared().getHeaders()).responseObject{
               (response: DataResponse<Volunteers>) in
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
    
    func createApplicationReqs(params : [String: AnyObject], callback: @escaping (CheckLoginResponse?) -> ()) {
        let header = Constants.shared().getHeaders()
        Alamofire.request(Constants.shared().baseUrl + "application/create", method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseObject{
            (response: DataResponse<CheckLoginResponse>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
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
    
    func acceptApplication(id : Int, callback: @escaping (StandartResponse?) -> ()) {
        let param = ["application_id": id]
        Alamofire.request(Constants.shared().baseUrl + "application/accept", method: .post, parameters: param, encoding: JSONEncoding.default, headers: Constants.shared().getHeaders()).responseObject{
               (response: DataResponse<StandartResponse>) in
               if let _ = response.response{
                   let model = response.result
                   callback(model.value ?? nil)
                   }
               }
       }

    func getFundRequests(id : Int, callback: @escaping (FundRequest?) -> ()) {
        
        Alamofire.request(Constants.shared().baseUrl + "fund/applications/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.shared().getHeaders()).responseObject{
               (response: DataResponse<FundRequest>) in
               if let _ = response.response{
                   let model = response.result
                   callback(model.value ?? nil)
                   }
               }
       }
    
    public func getMyFunds(page: Int, callback: @escaping (FundsResponse) -> ()){
        Alamofire.request(Constants.shared().baseUrl + "my/subscribed/funds?=\(page)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.shared().getHeaders()).responseObject{
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
    
    func getProfile(callback: @escaping (ProfileResponse?) -> ()) {
        let header = Constants.shared().getHeaders()
           Alamofire.request(Constants.shared().baseUrl + "profile", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
               (response: DataResponse<ProfileResponse>) in
               if let _ = response.response{
                   let model = response.result
                   callback(model.value ?? nil)
               }
           }
       }
    func editProfile(params : [String: AnyObject], callback: @escaping (StandartResponse?) -> ()) {
          let header = Constants.shared().getHeaders()
          Alamofire.request(Constants.shared().baseUrl + "profile/update", method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseObject{
              (response: DataResponse<StandartResponse>) in
              if let _ = response.response{
                  let model = response.result
                  callback(model.value ?? nil)
              }
          }
      }
}
