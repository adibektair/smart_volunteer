//
//  NewsObjevcts.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class News : NSObject, NSCoding, Mappable{

    var categories : Category?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return News()
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


class Category : NSObject, NSCoding, Mappable{

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


class Data : NSObject, NSCoding, Mappable{

    var categoryTypeId : Int?
    var createdAt : String?
    var deletedAt : AnyObject?
    var id : Int?
    var isVisible : Int?
    var name : String?
    var updatedAt : String?


    class func newInstance(map: Map) -> Mappable?{
        return Data()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        categoryTypeId <- map["category_type_id"]
        createdAt <- map["created_at"]
        deletedAt <- map["deleted_at"]
        id <- map["id"]
        isVisible <- map["is_visible"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         categoryTypeId = aDecoder.decodeObject(forKey: "category_type_id") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? AnyObject
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isVisible = aDecoder.decodeObject(forKey: "is_visible") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if categoryTypeId != nil{
            aCoder.encode(categoryTypeId, forKey: "category_type_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if deletedAt != nil{
            aCoder.encode(deletedAt, forKey: "deleted_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isVisible != nil{
            aCoder.encode(isVisible, forKey: "is_visible")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
