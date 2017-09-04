//
//  Demo1ViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit
import RandomKit

class Demo1ViewController: BaseDemoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = self.resetBarButtonItem
        
        self.title = "Demo1"
    }
    
    override func resetAction(_ sender: UIBarButtonItem?) {
        self.animator.removeAllBehaviors()
        self.view.subviews.forEach { $0.removeFromSuperview() }
    }

    override func tapAction(_ sender: UITapGestureRecognizer) {
        let location = tapGesture.location(in: self.view)

        let view = UIView(frame: CGRect(x: location.x, y: location.y, width: 50, height: 50))
        view.backgroundColor = UIColor.random(using: &Xoroshiro.default)
        self.view.addSubview(view)

        let gravity = UIGravityBehavior(items: [view])
        animator.addBehavior(gravity)

        let collision = UICollisionBehavior(items: [view])
        collision.collisionMode = .everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }

}
