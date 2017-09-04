//
//  Demo4ViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit
import SwiftLiteKit

class Demo4ViewController: BaseDemoViewController {
    
    let view1 = UIView(frame: CGRect(x: 50, y: 64, width: 50, height: 50))
    let view2 = UIView(frame: CGRect(x: 200, y: 400, width: 50, height: 50))
    
    var push: UIPushBehavior!
    var collision: UICollisionBehavior!
    
    var firstPoint: CGPoint?
    var lastPoint: CGPoint?
    var angle: CGFloat?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Demo4"
        
        self.view.addSubviews([view1, view2])
        self.randomSubViews()
        
        // 增加边界
        self.collision = UICollisionBehavior(items: self.view.subviews)
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(self.collision)
        
        // 推力行为
        self.push = UIPushBehavior(items: [view2], mode: .instantaneous)
        self.animator.addBehavior(self.push)
        
        _ = self.resetBarButtonItem
    }
    
    override func resetAction(_ sender: UIBarButtonItem?) {
        self.animator.removeAllBehaviors()
        
        self.view1.transform = CGAffineTransform.identity
        self.view2.transform = CGAffineTransform.identity
        
        self.view1.frame = CGRect(x: 50, y: 64, width: 50, height: 50)
        self.view2.frame = CGRect(x: 200, y: 400, width: 50, height: 50)
        
        self.animator.addBehavior(self.collision)
        self.animator.addBehavior(self.push)
    }
    
    override func panAction(_ sender: UIPanGestureRecognizer) {
        if panGesture.state == .began {
            self.firstPoint = panGesture.location(in: self.view)
        } else if panGesture.state == .changed {
            self.lastPoint = panGesture.location(in: self.view)
        } else if panGesture.state == .ended {
            
            guard let firstPoint = firstPoint, let lastPoint = lastPoint else {
                self.updateViewLayer()
                return
            }
            
            let offset = lastPoint - firstPoint
            
            self.angle = atan(offset.y / offset.x)
            
            if self.lastPoint!.x > self.firstPoint!.x {
                self.angle = self.angle! - CGFloat.pi
            }
            
            let distance = hypot(offset.y, offset.x)
            
            self.push.angle = self.angle! // 角度
            self.push.magnitude = distance / 10 // 推力
            self.push.active = true
            
            self.firstPoint = nil
            self.lastPoint = nil
            
        } else {
            self.firstPoint = nil
            self.lastPoint = nil
        }
        
        self.updateViewLayer()
    }
    
    func updateViewLayer() {
        
        guard let firstPoint = firstPoint, let lastPoint = lastPoint else {
            self.shapeLayer.path = nil
            return
            
        }
        
        let path = UIBezierPath()
        
        path.move(to: firstPoint)
        path.addLine(to: lastPoint)
        path.lineWidth = 7
        
        UIGraphicsBeginImageContext(self.view.bounds.size)
        path.stroke()
        UIGraphicsEndImageContext()
        
        self.shapeLayer.path = path.cgPath
        
        self.view.setNeedsLayout()
    }
}
