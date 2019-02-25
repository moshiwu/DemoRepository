//
//  AppDelegate.swift
//  SwiftiOSApp
//
//  Created by 莫锹文 on 2018/11/15.
//  Copyright © 2018 莫锹文. All rights reserved.
//

import JRSwizzle
import TYPagerController
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()

        do {
            try UIScrollView.jr_swizzleMethod(Selector("handlePan:"), withMethod: Selector("s_handlePan:"))

        } catch {
            print("swizzle error \(error)")
        }

        return true
    }
}
