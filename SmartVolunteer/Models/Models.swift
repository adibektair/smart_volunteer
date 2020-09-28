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
    var message : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return CheckLoginResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        isExists <- map["is_exists"]
        success <- map["success"]
        message <- map["message"]
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
        isVolunteer <- map["is_volunteer"]
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

class Fond : NSObject, NSCoding, Mappable{

    var city : City?
    var cityId : Int?
    var createdAt : String?
    var descriptionField : String?
    var id : Int?
    var imgPath : String?
    var name : String?
    var updatedAt : String?
    var volunteer : Volunteer?
    var volunteerNumber : Int?


    class func newInstance(map: Map) -> Mappable?{
        return Fond()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        city <- map["city"]
        cityId <- map["city_id"]
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        id <- map["id"]
        imgPath <- map["img_path"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        volunteer <- map["volunteer"]
        volunteerNumber <- map["volunteer_number"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         city = aDecoder.decodeObject(forKey: "city") as? City
         cityId = aDecoder.decodeObject(forKey: "city_id") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imgPath = aDecoder.decodeObject(forKey: "img_path") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         volunteer = aDecoder.decodeObject(forKey: "volunteer") as? Volunteer
         volunteerNumber = aDecoder.decodeObject(forKey: "volunteer_number") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
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
        if volunteer != nil{
            aCoder.encode(volunteer, forKey: "volunteer")
        }
        if volunteerNumber != nil{
            aCoder.encode(volunteerNumber, forKey: "volunteer_number")
        }

    }

}


class Fund1 : NSObject, NSCoding, Mappable {

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
        return Fund1()
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
         data = aDecoder.decodeObject(forKey: "data") as? [Fond]
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

class FundsResponse : NSObject, NSCoding, Mappable{

    var funds : Fund?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return FundsResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        funds <- map["funds"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         funds = aDecoder.decodeObject(forKey: "funds") as? Fund
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if funds != nil{
            aCoder.encode(funds, forKey: "funds")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}


class StandartResponse : NSObject, NSCoding, Mappable{

    var message : String?
    var success : Bool?
    var errorCode : Int?
    var errors : [String]?

    class func newInstance(map: Map) -> Mappable?{
        return StandartResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        message <- map["message"]
        success <- map["success"]
        errorCode <- map["errorCode"]
        errors <- map["errors"]
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         message = aDecoder.decodeObject(forKey: "message") as? String
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}


class Volunteers : NSObject, NSCoding, Mappable{

    var success : Bool?
    var volunteers : Volunteer?


    class func newInstance(map: Map) -> Mappable?{
        return Volunteers()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        success <- map["success"]
        volunteers <- map["volunteers"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         success = aDecoder.decodeObject(forKey: "success") as? Bool
         volunteers = aDecoder.decodeObject(forKey: "volunteers") as? Volunteer

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
        if volunteers != nil{
            aCoder.encode(volunteers, forKey: "volunteers")
        }

    }

}

class Volunteer : NSObject, NSCoding, Mappable{

    var outId = 0
    var createdAt : String?
    var fundId : Int?
    var id : Int?
    var updatedAt : String?
    var userId : Int?
    var applicationId : Int?
    var imgPath : String?
    var isVolunteer : Bool?
    var name : String?
    var role : City?
    var roleId : Int?
    var surname : String?
    var phone : String?
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
    var dataAll = [Data]()
    var inprogress = false
    var counter = 2

      
      func resetList(){
              self.dataAll.removeAll()
              if let arr = data {
                  self.dataAll.append(contentsOf: arr)
              }
          }
         func loadNextPage(done:@escaping (()-> Void)){
             if inprogress { return }
             if counter <= lastPage ?? 1{
                 inprogress = true
                Requests.shared().getVolunteersList(id: outId, page: counter) { (result) in
                    self.data?.append(contentsOf: result.volunteers?.data ?? [])
                    self.resetList()
                    self.counter += 1
                    self.inprogress = false
                    done()
                }
             }
         }
    class func newInstance(map: Map) -> Mappable?{
        return Volunteer()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        applicationId <- map["application_id"]
        createdAt <- map["created_at"]
        fundId <- map["fund_id"]
        id <- map["id"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
        imgPath <- map["img_path"]
        isVolunteer <- map["is_volunteer"]
        name <- map["name"]
        role <- map["role"]
        roleId <- map["role_id"]
        phone <- map["phone"]
        surname <- map["surname"]
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         fundId = aDecoder.decodeObject(forKey: "fund_id") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? Int

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
        if fundId != nil{
            aCoder.encode(fundId, forKey: "fund_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }

    }

}


class FundRequest : NSObject, NSCoding, Mappable{

    var applications : Application?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return FundRequest()
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


class Profile : NSObject, NSCoding, Mappable{

    var avatar : String?
    var city : String?
    var created : String?
    var id : Int?
    var iin : String?
    var language : String?
    var name : String?
    var phone : String?
    var surname : String?
    var cityId : Int?
    var langId : Int?

    class func newInstance(map: Map) -> Mappable?{
        return Profile()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        avatar <- map["avatar"]
        city <- map["city"]
        created <- map["created"]
        id <- map["id"]
        iin <- map["iin"]
        language <- map["language"]
        name <- map["name"]
        phone <- map["phone"]
        surname <- map["surname"]
        cityId <- map["city_id"]
        langId <- map["language_id"]

    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         avatar = aDecoder.decodeObject(forKey: "avatar") as? String
         city = aDecoder.decodeObject(forKey: "city") as? String
         created = aDecoder.decodeObject(forKey: "created") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         iin = aDecoder.decodeObject(forKey: "iin") as? String
         language = aDecoder.decodeObject(forKey: "language") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         surname = aDecoder.decodeObject(forKey: "surname") as? String

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
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if created != nil{
            aCoder.encode(created, forKey: "created")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if iin != nil{
            aCoder.encode(iin, forKey: "iin")
        }
        if language != nil{
            aCoder.encode(language, forKey: "language")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if surname != nil{
            aCoder.encode(surname, forKey: "surname")
        }

    }

}


class ProfileResponse : NSObject, NSCoding, Mappable{

    var profile : Profile?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return ProfileResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        profile <- map["profile"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         profile = aDecoder.decodeObject(forKey: "profile") as? Profile
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if profile != nil{
            aCoder.encode(profile, forKey: "profile")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}

class Feedbacks : NSObject, NSCoding, Mappable{

    var feedbacks : Feedback?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return Feedbacks()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        feedbacks <- map["feedbacks"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         feedbacks = aDecoder.decodeObject(forKey: "feedbacks") as? Feedback
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if feedbacks != nil{
            aCoder.encode(feedbacks, forKey: "feedbacks")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}


class Feedback : NSObject, NSCoding, Mappable{

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
        return Feedback()
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
