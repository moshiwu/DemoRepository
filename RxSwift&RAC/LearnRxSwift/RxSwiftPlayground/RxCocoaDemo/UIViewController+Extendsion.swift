//
//  UIViewController+Extendsion.swift
//  RxCocoaDemo
//
//  Created by 莫锹文 on 2017/8/25.
//

import UIKit

extension UIViewController {
    typealias AlertCallback = ((UIAlertAction) -> Void)

    func flash(title: String, message: String, callback: AlertCallback? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: callback)

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
}
