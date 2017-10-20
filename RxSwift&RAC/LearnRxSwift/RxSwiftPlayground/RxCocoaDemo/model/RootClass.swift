//
//	RootClass.swift
//
//	Create by 莫 锹文 on 6/9/2017
//	Copyright © 2017. All rights reserved.


import Foundation 
import ObjectMapper


class RootClass : NSObject, NSCoding, Mappable{

	var accessToken : String?
	var code : Int?
	var msg : String?
	var resMap : ResMap?
	var seq : String?


	class func newInstance(map: Map) -> Mappable?{
		return RootClass()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		accessToken <- map["accessToken"]
		code <- map["code"]
		msg <- map["msg"]
		resMap <- map["resMap"]
		seq <- map["seq"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
         code = aDecoder.decodeObject(forKey: "code") as? Int
         msg = aDecoder.decodeObject(forKey: "msg") as? String
         resMap = aDecoder.decodeObject(forKey: "resMap") as? ResMap
         seq = aDecoder.decodeObject(forKey: "seq") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if accessToken != nil{
			aCoder.encode(accessToken, forKey: "accessToken")
		}
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if msg != nil{
			aCoder.encode(msg, forKey: "msg")
		}
		if resMap != nil{
			aCoder.encode(resMap, forKey: "resMap")
		}
		if seq != nil{
			aCoder.encode(seq, forKey: "seq")
		}

	}

}