//
//  Demo3ViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit

class Demo3ViewController: BaseDemoViewController {

    var mainSprite = UIView(frame: CGRect(x: 0, y: 64, width: 20, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.mainSprite)
        self.randomSubViews()

        self.title = "Demo3"
    }

    override func tapAction(_ sender: UITapGestureRecognizer) {
        let location = self.tapGesture.location(in: self.view)
        self.snapBehavior(to: location)
    }

    override func panAction(_ sender: UIPanGestureRecognizer) {
        let location = self.panGesture.location(in: self.view)
        print(location)
        self.snapBehavior(to: location)
    }

    func snapBehavior(to location: CGPoint) {

        let snap = UISnapBehavior(item: self.mainSprite, snapTo: location)
        snap.damping = 0.5
        self.animator.removeAllBehaviors()
        self.animator.addBehavior(snap)
    }
}
