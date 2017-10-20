//
//  AppDelegate.swift
//  RxCocoaDemo
//
//  Created by 莫锹文 on 2017/8/22.
//

import UIKit
import Alamofire
import SwiftLiteKit
import APPSNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        #if swift(>=4.0)
            print("swift >= 4.0")
            #endif
        let s = "Hello Mars"
        var i = s.index(of: " ")!
        
        let greeting = s[..<i] // Hello
        let greetingWithSpace = s[...i] // "Hello "
        
        i = s.index(i, offsetBy: 1)
        let name = s[i...] // Mars
        
        print(s.substring(with: 1...))
        print(s.substring(with: ..<1))
        print(s.substring(with: ...1))
        
        print(s[1...])
        print(s[..<1])
        print(s[...1])

        return true
    }
    
}

