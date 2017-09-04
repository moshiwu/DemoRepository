//
//  Demo5ViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/4.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit

class Demo5ViewController: BaseDemoViewController {
    
    let view1 = UIView(frame: CGRect(x: 50, y: 64, width: 50, height: 50))
    let view2 = UIView(frame: CGRect(x: 200, y: 400, width: 5, height: 5))
    
    var attachment: UIAttachmentBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews([view1, view2])
        
        self.view1.center = CGPoint(x: 200, y: 200)
        self.view2.layer.cornerRadius = 2.5
        self.view2.layer.masksToBounds = true
        
        let anchorPoint = CGPoint(x: 200, y: 100)
        self.view2.center = anchorPoint
        
        let offset = UIOffset(horizontal: 20, vertical: 20)
        
        self.attachment = UIAttachmentBehavior(item: view1, offsetFromCenter: offset, attachedToAnchor: anchorPoint)
        self.attachment.damping = 0.8 // 如果不设置damping、frequency，则附着行为是刚性附着
        self.attachment.frequency = 0.5
        self.animator.addBehavior(self.attachment)
        
        let action = { [unowned self] in
            self.updateViewLayer()
        }
        
        // 添加重力行为
        let gra = UIGravityBehavior(items: [view1])
        self.animator.addBehavior(gra)
        
        gra.action = action
        self.attachment.action = action
        
        randomSubViews()
        updateViewLayer()
        
    }
    
    override func panAction(_ sender: UIPanGestureRecognizer) {
        let location = self.panGesture.location(in: self.view)
        
        self.view2.center = location
        self.attachment.anchorPoint = location
        
        updateViewLayer()
    }
    
    func updateViewLayer() {
        
        let path = UIBezierPath()
        
        path.move(to: view1.center)
        path.addLine(to: view2.center)
        
        UIGraphicsBeginImageContext(self.view.bounds.size)
        path.stroke()
        UIGraphicsEndImageContext()
        
        self.shapeLayer.path = path.cgPath
        
        self.view.setNeedsLayout()
    }
}
