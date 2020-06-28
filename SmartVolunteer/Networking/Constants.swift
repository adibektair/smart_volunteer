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
        let headers = ["Authorization" : "Bearer " + self.getToken()!]
        return headers
    }
    
    public let baseUrl = "https://sups.kz/api/v1/"
    
    
}
