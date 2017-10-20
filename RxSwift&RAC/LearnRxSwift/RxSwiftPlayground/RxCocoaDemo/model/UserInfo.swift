//
//	UserInfo.swift
//
//	Create by 莫 锹文 on 6/9/2017
//	Copyright © 2017. All rights reserved.


import Foundation 
import ObjectMapper


class UserInfo : NSObject, NSCoding, Mappable{

	var addreddIp : AnyObject?
	var area : AnyObject?
	var backgroundWall : AnyObject?
	var birthday : String?
	var city : AnyObject?
	var country : AnyObject?
	var height : Int?
	var heightUnit : Int?
	var iconUrl : AnyObject?
	var isManage : Int?
	var motto : AnyObject?
	var nickname : AnyObject?
	var province : AnyObject?
	var refUserId : Int?
	var sex : Int?
	var themeColor : AnyObject?
	var userInfoId : Int?
	var userName : String?
	var weight : Int?
	var weightUnit : Int?


	class func newInstance(map: Map) -> Mappable?{
		return UserInfo()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		addreddIp <- map["addreddIp"]
		area <- map["area"]
		backgroundWall <- map["backgroundWall"]
		birthday <- map["birthday"]
		city <- map["city"]
		country <- map["country"]
		height <- map["height"]
		heightUnit <- map["heightUnit"]
		iconUrl <- map["iconUrl"]
		isManage <- map["isManage"]
		motto <- map["motto"]
		nickname <- map["nickname"]
		province <- map["province"]
		refUserId <- map["refUserId"]
		sex <- map["sex"]
		themeColor <- map["themeColor"]
		userInfoId <- map["userInfoId"]
		userName <- map["userName"]
		weight <- map["weight"]
		weightUnit <- map["weightUnit"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         addreddIp = aDecoder.decodeObject(forKey: "addreddIp") as? AnyObject
         area = aDecoder.decodeObject(forKey: "area") as? AnyObject
         backgroundWall = aDecoder.decodeObject(forKey: "backgroundWall") as? AnyObject
         birthday = aDecoder.decodeObject(forKey: "birthday") as? String
         city = aDecoder.decodeObject(forKey: "city") as? AnyObject
         country = aDecoder.decodeObject(forKey: "country") as? AnyObject
         height = aDecoder.decodeObject(forKey: "height") as? Int
         heightUnit = aDecoder.decodeObject(forKey: "heightUnit") as? Int
         iconUrl = aDecoder.decodeObject(forKey: "iconUrl") as? AnyObject
         isManage = aDecoder.decodeObject(forKey: "isManage") as? Int
         motto = aDecoder.decodeObject(forKey: "motto") as? AnyObject
         nickname = aDecoder.decodeObject(forKey: "nickname") as? AnyObject
         province = aDecoder.decodeObject(forKey: "province") as? AnyObject
         refUserId = aDecoder.decodeObject(forKey: "refUserId") as? Int
         sex = aDecoder.decodeObject(forKey: "sex") as? Int
         themeColor = aDecoder.decodeObject(forKey: "themeColor") as? AnyObject
         userInfoId = aDecoder.decodeObject(forKey: "userInfoId") as? Int
         userName = aDecoder.decodeObject(forKey: "userName") as? String
         weight = aDecoder.decodeObject(forKey: "weight") as? Int
         weightUnit = aDecoder.decodeObject(forKey: "weightUnit") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if addreddIp != nil{
			aCoder.encode(addreddIp, forKey: "addreddIp")
		}
		if area != nil{
			aCoder.encode(area, forKey: "area")
		}
		if backgroundWall != nil{
			aCoder.encode(backgroundWall, forKey: "backgroundWall")
		}
		if birthday != nil{
			aCoder.encode(birthday, forKey: "birthday")
		}
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if heightUnit != nil{
			aCoder.encode(heightUnit, forKey: "heightUnit")
		}
		if iconUrl != nil{
			aCoder.encode(iconUrl, forKey: "iconUrl")
		}
		if isManage != nil{
			aCoder.encode(isManage, forKey: "isManage")
		}
		if motto != nil{
			aCoder.encode(motto, forKey: "motto")
		}
		if nickname != nil{
			aCoder.encode(nickname, forKey: "nickname")
		}
		if province != nil{
			aCoder.encode(province, forKey: "province")
		}
		if refUserId != nil{
			aCoder.encode(refUserId, forKey: "refUserId")
		}
		if sex != nil{
			aCoder.encode(sex, forKey: "sex")
		}
		if themeColor != nil{
			aCoder.encode(themeColor, forKey: "themeColor")
		}
		if userInfoId != nil{
			aCoder.encode(userInfoId, forKey: "userInfoId")
		}
		if userName != nil{
			aCoder.encode(userName, forKey: "userName")
		}
		if weight != nil{
			aCoder.encode(weight, forKey: "weight")
		}
		if weightUnit != nil{
			aCoder.encode(weightUnit, forKey: "weightUnit")
		}

	}

}