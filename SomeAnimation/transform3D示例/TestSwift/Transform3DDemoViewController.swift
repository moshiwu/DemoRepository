//
//  Transform3DDemoViewController.swift
//  TestSwift
//
//  Created by 莫锹文 on 2017/10/18.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit
import YYKit

enum SliderType: Int {
    case x = 1
    case y = 2
    case z = 3
    case m34 = 4
    case rotationX = 5
    case rotationY = 6
    case rotationZ = 7
}

class Transform3DDemoViewController: UIViewController {

    @IBOutlet weak var sliderX: UISlider!
    @IBOutlet weak var sliderY: UISlider!
    @IBOutlet weak var sliderZ: UISlider!
    @IBOutlet weak var sliderM34: UISlider!

    @IBOutlet weak var sliderRotationX: UISlider!
    @IBOutlet weak var sliderRotationY: UISlider!
    @IBOutlet weak var sliderRotationZ: UISlider!

    @IBOutlet weak var sliderScaleX: UISlider!
    @IBOutlet weak var sliderScaleY: UISlider!
    @IBOutlet weak var sliderScaleZ: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIBarButtonItem(title: "reset", style: .done, target: self, action: #selector(button_handler))
        navigationItem.rightBarButtonItem = button
    }

    @objc func button_handler() {
        imageView.layer.transform = CATransform3DIdentity

        sliderScaleX.value = 1
        sliderScaleY.value = 1
        sliderScaleZ.value = 1
        sliderX.value = 0
        sliderY.value = 0
        sliderZ.value = 0
        sliderRotationX.value = 0
        sliderRotationY.value = 0
        sliderRotationZ.value = 0
        sliderM34.value = 0
    }

    @IBAction func slider_handler(_ sender: UISlider) {

        var currentTransform = imageView.layer.transform
        guard let tag = SliderType(rawValue: sender.tag) else {
            print("slider tag error")
            return
        }

        imageView.layer.transform = CATransform3DIdentity
        imageView.layer.transformScaleX = CGFloat(sliderScaleX.value)
        imageView.layer.transformScaleY = CGFloat(sliderScaleY.value)
        imageView.layer.transformScaleZ = CGFloat(sliderScaleZ.value)
        imageView.layer.transformTranslationX = CGFloat(sliderX.value)
        imageView.layer.transformTranslationY = CGFloat(sliderY.value)
        imageView.layer.transformTranslationZ = CGFloat(sliderZ.value)
        imageView.layer.transformDepth = CGFloat(sliderM34.value) / 5000
        imageView.layer.transformRotationX = CGFloat(sliderRotationX.value) * CGFloat.pi / 180
        imageView.layer.transformRotationY = CGFloat(sliderRotationY.value) * CGFloat.pi / 180
        imageView.layer.transformRotationZ = CGFloat(sliderRotationZ.value) * CGFloat.pi / 180

        logT(imageView.layer.transform)
        logF(imageView, "transform.rotation.x")
        logF(imageView, "transform.rotation.y")
        logF(imageView, "transform.rotation.z")
        print("slider value : \(sender.value)")

    }
    @IBOutlet weak var imageView: UIImageView!
}

func logT(_ value: CATransform3D) {
    print("------------")
    print(NSString(format: "%@, %@, %@, %@", innerLog(value.m11), innerLog(value.m12), innerLog(value.m13), innerLog(value.m14)))
    print(NSString(format: "%@, %@, %@, %@", innerLog(value.m21), innerLog(value.m22), innerLog(value.m23), innerLog(value.m24)))
    print(NSString(format: "%@, %@, %@, %@", innerLog(value.m31), innerLog(value.m32), innerLog(value.m33), innerLog(value.m34)))
    print(NSString(format: "%@, %@, %@, %@", innerLog(value.m41), innerLog(value.m42), innerLog(value.m43), innerLog(value.m44)))
    print("--------------------------------------------------------------")

}

func innerLog(_ value: CGFloat) -> NSString {
    let str = NSString(format: "%.8f", value)

    return str.length == 11 ? str : NSString(format: " %@", str)
}

func logF(_ target: UIView, _ key: String) {
    if let value = target.layer.value(forKeyPath: key) as? NSNumber {
        print(value.doubleValue * 180 / Double.pi)
    }

}
