//
//  Constants.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/21/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    private static var sharedReference : Constants{
          let headers = Constants()
          return headers
    }
    
    class func shared() -> Constants {
          return sharedReference
    }
    
    func saveToken(token : String){
        UserDefaults.standard.set(token, forKey: "token")
    }
    func getToken() -> String?{
        return UserDefaults.standard.string(forKey: "token")
    }
    
    func setRole(isVolunteer : Bool?){
        UserDefaults.standard.set(isVolunteer ?? false, forKey: "isVolunteer")
    }
    func isVolunteer() -> Bool{
        return UserDefaults.standard.bool(forKey: "isVolunteer")
    }
    func getHeaders() -> [String : String]{
        if self.getToken() == nil{
            return [:]
        }
        let headers = ["Authorization" : "Bearer " + self.getToken()!]
        return headers
    }
    public func clear(){
          let domain = Bundle.main.bundleIdentifier!
          UserDefaults.standard.removePersistentDomain(forName: domain)
          UserDefaults.standard.synchronize()
          print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
      }
    
    public var secure = false
    
    public let isTaraz = true
    
    public var baseUrl : String = "https://taraz.smartvolunteer.kz/api/v1/" {
//        public var baseUrl : String = "https://tdk.smartvolunteer.kz/api/v1/" {
        didSet {
            if isTaraz {
//                self.baseUrl = "https://taraz.smartvolunteer.kz/api/v1/"
            } else {
//                self.baseUrl = "https://tdk.smartvolunteer.kz/api/v1/"
            }
        }
    }
    
    public func baseUrl(version : Int = 1) -> String{
        return "https://taraz.smartvolunteer.kz/api/v\(version)/"
    }

}
