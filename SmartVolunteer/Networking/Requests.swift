//
//  Requests.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/21/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit

class Requests: NSObject {
    
    private static var sharedReference : Requests{
          let headers = Requests()
          return headers
    }
    
    class func shared() -> Requests {
          return sharedReference
    }
    
    
}
