//
//	ResMap.swift
//
//	Create by 莫 锹文 on 6/9/2017
//	Copyright © 2017. All rights reserved.


import Foundation 
import ObjectMapper


class ResMap : NSObject, NSCoding, Mappable{

	var accountId : String?
	var apiNo : Int?
	var mobilePhone : AnyObject?
	var userInfo : UserInfo?


	class func newInstance(map: Map) -> Mappable?{
		return ResMap()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		accountId <- map["accountId"]
		apiNo <- map["apiNo"]
		mobilePhone <- map["mobilePhone"]
		userInfo <- map["userInfo"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         accountId = aDecoder.decodeObject(forKey: "accountId") as? String
         apiNo = aDecoder.decodeObject(forKey: "apiNo") as? Int
         mobilePhone = aDecoder.decodeObject(forKey: "mobilePhone") as? AnyObject
         userInfo = aDecoder.decodeObject(forKey: "userInfo") as? UserInfo

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if accountId != nil{
			aCoder.encode(accountId, forKey: "accountId")
		}
		if apiNo != nil{
			aCoder.encode(apiNo, forKey: "apiNo")
		}
		if mobilePhone != nil{
			aCoder.encode(mobilePhone, forKey: "mobilePhone")
		}
		if userInfo != nil{
			aCoder.encode(userInfo, forKey: "userInfo")
		}

	}

}