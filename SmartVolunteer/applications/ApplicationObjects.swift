//
//  ApplicationObjects.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/26/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import Foundation
import ObjectMapper


class Applications : NSObject, NSCoding, Mappable{

    var applications : Application?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return Applications()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        applications <- map["applications"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         applications = aDecoder.decodeObject(forKey: "applications") as? Application
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if applications != nil{
            aCoder.encode(applications, forKey: "applications")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}

class Application : NSObject, NSCoding, Mappable{

    var currentPage : Int?
    var data : [Data]?
    var firstPageUrl : String?
    var from : Int?
    var lastPage : Int?
    var lastPageUrl : String?
    var nextPageUrl : AnyObject?
    var path : String?
    var perPage : Int?
    var prevPageUrl : AnyObject?
    var to : Int?
    var total : Int?


    class func newInstance(map: Map) -> Mappable?{
        return Application()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        currentPage <- map["current_page"]
        data <- map["data"]
        firstPageUrl <- map["first_page_url"]
        from <- map["from"]
        lastPage <- map["last_page"]
        lastPageUrl <- map["last_page_url"]
        nextPageUrl <- map["next_page_url"]
        path <- map["path"]
        perPage <- map["per_page"]
        prevPageUrl <- map["prev_page_url"]
        to <- map["to"]
        total <- map["total"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         currentPage = aDecoder.decodeObject(forKey: "current_page") as? Int
         data = aDecoder.decodeObject(forKey: "data") as? [Data]
         firstPageUrl = aDecoder.decodeObject(forKey: "first_page_url") as? String
         from = aDecoder.decodeObject(forKey: "from") as? Int
         lastPage = aDecoder.decodeObject(forKey: "last_page") as? Int
         lastPageUrl = aDecoder.decodeObject(forKey: "last_page_url") as? String
         nextPageUrl = aDecoder.decodeObject(forKey: "next_page_url") as? AnyObject
         path = aDecoder.decodeObject(forKey: "path") as? String
         perPage = aDecoder.decodeObject(forKey: "per_page") as? Int
         prevPageUrl = aDecoder.decodeObject(forKey: "prev_page_url") as? AnyObject
         to = aDecoder.decodeObject(forKey: "to") as? Int
         total = aDecoder.decodeObject(forKey: "total") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if currentPage != nil{
            aCoder.encode(currentPage, forKey: "current_page")
        }
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if firstPageUrl != nil{
            aCoder.encode(firstPageUrl, forKey: "first_page_url")
        }
        if from != nil{
            aCoder.encode(from, forKey: "from")
        }
        if lastPage != nil{
            aCoder.encode(lastPage, forKey: "last_page")
        }
        if lastPageUrl != nil{
            aCoder.encode(lastPageUrl, forKey: "last_page_url")
        }
        if nextPageUrl != nil{
            aCoder.encode(nextPageUrl, forKey: "next_page_url")
        }
        if path != nil{
            aCoder.encode(path, forKey: "path")
        }
        if perPage != nil{
            aCoder.encode(perPage, forKey: "per_page")
        }
        if prevPageUrl != nil{
            aCoder.encode(prevPageUrl, forKey: "prev_page_url")
        }
        if to != nil{
            aCoder.encode(to, forKey: "to")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }

    }

}

class Fund : NSObject, NSCoding, Mappable{

    var cityId : Int?
    var createdAt : String?
    var descriptionField : String?
    var id : Int?
    var imgPath : String?
    var name : String?
    var updatedAt : String?
    var volunteerNumber : Int?    
    var currentPage : Int?
    var data : [Fond]?
    var firstPageUrl : String?
    var from : Int?
    var lastPage : Int?
    var lastPageUrl : String?
    var nextPageUrl : AnyObject?
    var path : String?
    var perPage : Int?
    var prevPageUrl : AnyObject?
    var to : Int?
    var total : Int?


    class func newInstance(map: Map) -> Mappable?{
        return Fund()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        cityId <- map["city_id"]
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        id <- map["id"]
        imgPath <- map["img_path"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        volunteerNumber <- map["volunteer_number"]
        currentPage <- map["current_page"]
        data <- map["data"]
        firstPageUrl <- map["first_page_url"]
        from <- map["from"]
        lastPage <- map["last_page"]
        lastPageUrl <- map["last_page_url"]
        nextPageUrl <- map["next_page_url"]
        path <- map["path"]
        perPage <- map["per_page"]
        prevPageUrl <- map["prev_page_url"]
        to <- map["to"]
        total <- map["total"]
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         cityId = aDecoder.decodeObject(forKey: "city_id") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imgPath = aDecoder.decodeObject(forKey: "img_path") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         volunteerNumber = aDecoder.decodeObject(forKey: "volunteer_number") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if cityId != nil{
            aCoder.encode(cityId, forKey: "city_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imgPath != nil{
            aCoder.encode(imgPath, forKey: "img_path")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if volunteerNumber != nil{
            aCoder.encode(volunteerNumber, forKey: "volunteer_number")
        }

    }

}

class Category : NSObject, NSCoding, Mappable{

    var id : Int?
    var name : String?
    var currentPage : Int?
    var data : [Data]?
    var firstPageUrl : String?
    var from : Int?
    var lastPage : Int?
    var lastPageUrl : String?
    var nextPageUrl : AnyObject?
    var path : String?
    var perPage : Int?
    var prevPageUrl : AnyObject?
    var to : Int?
    var total : Int?


    class func newInstance(map: Map) -> Mappable?{
        return Category()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        id <- map["id"]
        name <- map["name"]
        currentPage <- map["current_page"]
        data <- map["data"]
        firstPageUrl <- map["first_page_url"]
        from <- map["from"]
        lastPage <- map["last_page"]
        lastPageUrl <- map["last_page_url"]
        nextPageUrl <- map["next_page_url"]
        path <- map["path"]
        perPage <- map["per_page"]
        prevPageUrl <- map["prev_page_url"]
        to <- map["to"]
        total <- map["total"]
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }

    }

}

class Categories : NSObject, NSCoding, Mappable{

    var categories : Category?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return Categories()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        categories <- map["categories"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         categories = aDecoder.decodeObject(forKey: "categories") as? Category
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if categories != nil{
            aCoder.encode(categories, forKey: "categories")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}

class Types : NSObject, NSCoding, Mappable{

    var success : Bool?
    var types : [Type]?


    class func newInstance(map: Map) -> Mappable?{
        return Types()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        success <- map["success"]
        types <- map["types"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         success = aDecoder.decodeObject(forKey: "success") as? Bool
         types = aDecoder.decodeObject(forKey: "types") as? [Type]
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }
        if types != nil{
            aCoder.encode(types, forKey: "types")
        }

    }

}

class Type : NSObject, NSCoding, Mappable{

    var createdAt : AnyObject?
    var deletedAt : AnyObject?
    var id : Int?
    var name : String?
    var updatedAt : AnyObject?


    class func newInstance(map: Map) -> Mappable?{
        return Type()
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
