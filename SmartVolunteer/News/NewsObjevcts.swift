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
    
    var news : New?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return News()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        news <- map["news"]
        success <- map["success"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        news = aDecoder.decodeObject(forKey: "news") as? New
        success = aDecoder.decodeObject(forKey: "success") as? Bool
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if news != nil{
            aCoder.encode(news, forKey: "news")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }
        
    }
    
}


class New : NSObject, NSCoding, Mappable{
    
    var currentPage : Int?
    var data : [Data]?
    var dataAll = [Data]()
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
    var inprogress = false
    var counter = 2
    
    
    func resetList(){
        self.dataAll.removeAll()
        if let arr = data {
            self.dataAll.append(contentsOf: arr)
        }
    }
    func loadNextPage(search: String,done:@escaping (()-> Void)){
        if inprogress { return }
        if counter <= lastPage ?? 1{
            inprogress = true
            Requests.shared().getNews(page: counter,search: search) { (result) in
                self.data?.append(contentsOf: result.news?.data ?? [])
                self.resetList()
                self.counter += 1
                self.inprogress = false
                done()
            }
        }
    }
    
    class func newInstance(map: Map) -> Mappable?{
        return New()
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
    
    var address : String?
    var categoryId : Int?
    var createdAt : String?
    var fullText : String?
    var id : Int?
    var imgPath : String?
    var readMinutes : Int?
    var title : String?
    var updatedAt : String?
    var viewsCount : Int?
    var applicationTypeId : Int?
    var category : Category?
    var city : City?
    var cityId : Int?
    var descriptionField : String?
    var fund : Fund?
    var fundId : Int?
    var user : User?
    var userId : AnyObject?
    var volunteer : Volunteer?
    var volunteerNumber : Int?
    var volunteerNumberAccessed : Int?
    var categoryTypeId : Int?
    var deletedAt : AnyObject?
    var isVisible : Int?
    var name : String?
    var isVolunteer : Bool?
    var phone : String?
    var role : Role?
    var roleId : Int?
    var surname : String?
    var application : Application?
    var applicationId : Int?
    var mark : Int?
    var text : String?
    var ratingScore: Double?
    var feedbacks : [Feedback]?
    var status: Int?
    var lat : Double?
    var lng : Double?

    class func newInstance(map: Map) -> Mappable?{
        return Data()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        address <- map["address"]
        application <- map["application"]
        applicationId <- map["application_id"]
        mark <- map["mark"]
        text <- map["text"]
        categoryId <- map["category_id"]
        createdAt <- map["created_at"]
        fullText <- map["full_text"]
        id <- map["id"]
        imgPath <- map["img_path"]
        readMinutes <- map["read_minutes"]
        title <- map["title"]
        updatedAt <- map["updated_at"]
        viewsCount <- map["views_count"]
        applicationTypeId <- map["application_type_id"]
        category <- map["category"]
        city <- map["city"]
        cityId <- map["city_id"]
        descriptionField <- map["description"]
        feedbacks <- map["feedbacks"]
        fund <- map["fund"]
        fundId <- map["fund_id"]
        user <- map["user"]
        userId <- map["user_id"]
        volunteer <- map["volunteer"]
        volunteerNumber <- map["volunteer_number"]
        volunteerNumberAccessed <- map["volunteer_number_accessed"]
        categoryTypeId <- map["category_type_id"]
        deletedAt <- map["deleted_at"]
        isVisible <- map["is_visible"]
        name <- map["name"]
        isVolunteer <- map["is_volunteer"]
        phone <- map["phone"]
        ratingScore <- map["rating_score"]
        role <- map["role"]
        roleId <- map["role_id"]
        surname <- map["surname"]
        status <- map["status"]
        lat <- map["lat"]
        lng <- map["lng"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        categoryId = aDecoder.decodeObject(forKey: "category_id") as? Int
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        fullText = aDecoder.decodeObject(forKey: "full_text") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imgPath = aDecoder.decodeObject(forKey: "img_path") as? String
        readMinutes = aDecoder.decodeObject(forKey: "read_minutes") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        viewsCount = aDecoder.decodeObject(forKey: "views_count") as? Int
        
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if categoryId != nil{
            aCoder.encode(categoryId, forKey: "category_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if fullText != nil{
            aCoder.encode(fullText, forKey: "full_text")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imgPath != nil{
            aCoder.encode(imgPath, forKey: "img_path")
        }
        if readMinutes != nil{
            aCoder.encode(readMinutes, forKey: "read_minutes")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if viewsCount != nil{
            aCoder.encode(viewsCount, forKey: "views_count")
        }
        
    }
    
}


class User : NSObject, NSCoding, Mappable{
    
    
    var id : Int?
    var iin : String?
    var imgPath : String?
    var isVolunteer : Bool?
    var name : String?
    var ratingScore : Int?
    var role : Role?
    var roleId : Int?
    var surname : String?
    var phone: String?
    var avgMark : String?
    var doneWorks : Int?
    var email : String?

    
    class func newInstance(map: Map) -> Mappable?{
        return User()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["id"]
        iin <- map["iin"]
        imgPath <- map["img_path"]
        isVolunteer <- map["is_volunteer"]
        name <- map["name"]
        ratingScore <- map["rating_score"]
        role <- map["role"]
        roleId <- map["role_id"]
        surname <- map["surname"]
        phone <- map["phone"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imgPath = aDecoder.decodeObject(forKey: "img_path") as? String
        isVolunteer = aDecoder.decodeObject(forKey: "is_volunteer") as? Bool
        name = aDecoder.decodeObject(forKey: "name") as? String
        role = aDecoder.decodeObject(forKey: "role") as? Role
        roleId = aDecoder.decodeObject(forKey: "role_id") as? Int
        surname = aDecoder.decodeObject(forKey: "surname") as? String
        
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
        if imgPath != nil{
            aCoder.encode(imgPath, forKey: "img_path")
        }
        if isVolunteer != nil{
            aCoder.encode(isVolunteer, forKey: "is_volunteer")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if role != nil{
            aCoder.encode(role, forKey: "role")
        }
        if roleId != nil{
            aCoder.encode(roleId, forKey: "role_id")
        }
        if surname != nil{
            aCoder.encode(surname, forKey: "surname")
        }
        
    }
    
}
class Role : NSObject, NSCoding, Mappable{
    
    var createdAt : AnyObject?
    var deletedAt : AnyObject?
    var id : Int?
    var name : String?
    var updatedAt : AnyObject?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Role()
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
