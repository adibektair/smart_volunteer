//
//  Models.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/24/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import Foundation
import ObjectMapper


class CheckLoginResponse : NSObject, NSCoding, Mappable{

    var isExists : Bool?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return CheckLoginResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        isExists <- map["is_exists"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         isExists = aDecoder.decodeObject(forKey: "is_exists") as? Bool
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if isExists != nil{
            aCoder.encode(isExists, forKey: "is_exists")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}



class City : NSObject, NSCoding, Mappable{

    var createdAt : AnyObject?
    var deletedAt : AnyObject?
    var id : Int?
    var name : String?
    var updatedAt : AnyObject?


    class func newInstance(map: Map) -> Mappable?{
        return City()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        deletedAt <- map["deleted_at"]
        id <- map["id"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? AnyObject
         deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? AnyObject
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? AnyObject

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if deletedAt != nil{
            aCoder.encode(deletedAt, forKey: "deleted_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}



class CitiesResponse : NSObject, NSCoding, Mappable{

    var cities : [City]?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return CitiesResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        cities <- map["cities"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         cities = aDecoder.decodeObject(forKey: "cities") as? [City]
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if cities != nil{
            aCoder.encode(cities, forKey: "cities")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}


class RegisterResponse : NSObject, NSCoding, Mappable{

    var avatar : String?
    var name : String?
    var success : Bool?
    var surname : String?
    var token : String?
    var isVolunteer : Bool?

    class func newInstance(map: Map) -> Mappable?{
        return RegisterResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        avatar <- map["avatar"]
        name <- map["name"]
        success <- map["success"]
        surname <- map["surname"]
        token <- map["token"]
        isVolunteer <- map["is_volunterr"]
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         avatar = aDecoder.decodeObject(forKey: "avatar") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         success = aDecoder.decodeObject(forKey: "success") as? Bool
         surname = aDecoder.decodeObject(forKey: "surname") as? String
         token = aDecoder.decodeObject(forKey: "token") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if avatar != nil{
            aCoder.encode(avatar, forKey: "avatar")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }
        if surname != nil{
            aCoder.encode(surname, forKey: "surname")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }

    }

}
