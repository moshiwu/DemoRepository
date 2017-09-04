//
//  Demo2ViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit
import RandomKit
import SwiftLiteKit

class Demo2ViewController: BaseDemoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetAction(nil)

        _ = self.resetBarButtonItem
        _ = self.startBarButtonItem

        self.title = "Demo2"
    }

    override func resetAction(_ sender: UIBarButtonItem?) {

        let view1 = UIView(frame: CGRect(x: 55, y: 64 + 50, width: 300, height: 20))
        let view2 = UIView(frame: CGRect(x: 190, y: 64 + 180, width: 50, height: 50))
        let view3 = UIView(frame: CGRect(x: 260, y: 64 + 180, width: 40, height: 40))
        let view4 = UIView(frame: CGRect(x: 50, y: 64 + 290, width: 30, height: 30))

        self.view.removeAllSubviews()
        self.view.addSubviews([view1, view2, view3, view4])
        self.view.subviews.forEach { $0.backgroundColor = UIColor.random(using: &Xoroshiro.default) }
    }

    override func startAction(_ sender: UIBarButtonItem) {

        var views = self.view.subviews as [UIView]

        let gravity1 = UIGravityBehavior(items: [views.remove(at: 0)])
        animator.addBehavior(gravity1)
        gravity1.magnitude = 0.1

        // 一个Animator只能包含一个重力行为，重复的话，新的重力行为的参数会覆盖旧的（magnitude、gravityDirection等）
        let gravity2 = UIGravityBehavior(items: views)
        gravity2.gravityDirection = CGVector(dx: 0, dy: -1)
        animator.addBehavior(gravity2)

        let collision = UICollisionBehavior(items: self.view.subviews)
        collision.collisionMode = .everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }
}
