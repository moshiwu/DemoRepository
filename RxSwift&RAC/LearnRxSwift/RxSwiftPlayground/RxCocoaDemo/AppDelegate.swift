//
//  AppDelegate.swift
//  RxCocoaDemo
//
//  Created by 莫锹文 on 2017/8/22.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let r = APPSLoginRequest()
        r.accountId = "account"
        r.password = "password"
        r.customerCode = "test"

        let a = AccountAPI.login(model: r)

        print(a.toJSONString()!)
        print(r.toJSONString()!)

        let ttt = A()

        do {
            let value = try JSONEncoder().encode(ttt)
            
            
            print(value)

        } catch {
            print(error)
        }
        return true
    }
}

protocol PropertyPrinter {
    func propertyList() -> [String]
}

extension PropertyPrinter where Self: NSObject {
    func propertyList() -> [String] {
        var count: UInt32 = 0
        // 获取类的属性列表,返回属性列表的数组,可选项
        let list = class_copyPropertyList(self.classForCoder, &count)
        print("属性个数:\(count)")
        // 遍历数组
        for i in 0..<Int(count) {
            // 根据下标获取属性
            let pty = list?[i]
            // 获取属性的名称<C语言字符串>
            // 转换过程:Int8 -> Byte -> Char -> C语言字符串
            let cName = property_getName(pty!)
            // 转换成String的字符串
            let name = String(utf8String: cName!)
            print(name!)
        }
        free(list) // 释放list
        return []
    }
}

class A: Codable {
    var name: String = "123"
    func test() {

    }
}

extension APPSLoginRequest: BaseMappable {
    public func mapping(map: Map) {
        accountId <- map["accountId"]

    }

}

public protocol APPSRequest: URLRequestConvertible {
    var host: String { get }
    var header: HTTPHeaders { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var seq: TimeInterval { get }
    var versionNo: String { get }
    var clientType: String { get }
    var accessToken: String? { get set }
}

extension APPSRequest {
    public var host: String { return "https://new.fashioncomm.com" }
    public var header: HTTPHeaders { return ["Content-type": "application/json", "accept": "application/json"] }
    public var method: HTTPMethod { return .get }
    public var seq: TimeInterval { return Date().timeIntervalSince1970 }
    public var versionNo: String { return "2.0" }
    public var clientType: String { return "iphone" }
    public var parameters: Parameters? { return [:] }

    public var accessToken: String? {
        get { return "testToken" }
        set {}
    }
}
import APPSNetworking
import ObjectMapper

extension Dictionary where Key == String, Value: Any {
    func test() {
        print("ttt")
    }
}

public enum AccountAPI: APPSRequest, Mappable {
    var a: String { return "a" }
    public init?(map: Map) {
        self.init(map: map)
    }

    public mutating func mapping(map: Map) {
        accessToken <- map["accessToken"]
    }

    case login(model: APPSLoginRequest)
    case register(model: APPSRegisterRequest)

    public func asURLRequest() throws -> URLRequest {

        return URLRequest(url: URL(string: "")!)
    }
}
