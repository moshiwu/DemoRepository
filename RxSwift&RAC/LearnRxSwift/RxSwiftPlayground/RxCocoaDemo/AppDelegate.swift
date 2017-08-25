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

        print(a.toJSONString())
        return true
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
        get { return "" }
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

    }

    case login(model: APPSLoginRequest)
    case register(model: APPSRegisterRequest)

    public func asURLRequest() throws -> URLRequest {

        return URLRequest(url: URL(string: "")!)
    }
}
