//
//  StringExtension.swift
//  Tensend(new)
//
//  Created by Sultan on 2/14/20.
//  Copyright © 2020 adibek. All rights reserved.
//

import UIKit

extension String{
    
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
    
}
