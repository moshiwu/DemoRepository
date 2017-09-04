//
//  BaseDemoViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit
import RandomKit

class BaseDemoViewController: UIViewController {

    lazy var animator = UIDynamicAnimator(referenceView: self.view)
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))

    lazy var resetBarButtonItem = { () -> UIBarButtonItem in
        let item = UIBarButtonItem(title: "重置", style: .plain, target: self, action: #selector(resetAction))
        guard let items = self.navigationItem.rightBarButtonItems else { self.navigationItem.rightBarButtonItem = item; return item }
        self.navigationItem.rightBarButtonItems?.append(item)
        return item
    }()

    lazy var startBarButtonItem = { () -> UIBarButtonItem in
        let item = UIBarButtonItem(title: "开始", style: .plain, target: self, action: #selector(startAction))
        guard let items = self.navigationItem.rightBarButtonItems else { self.navigationItem.rightBarButtonItem = item; return item }
        self.navigationItem.rightBarButtonItems?.append(item)
        return item
    }()

    lazy var shapeLayer = { () -> CAShapeLayer in
        let layer = CAShapeLayer()
        layer.frame = self.view.frame
        layer.strokeColor = UIColor.lightGray.cgColor
        self.view.layer.addSublayer(layer)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(panGesture)
        self.view.isUserInteractionEnabled = true
    }

    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        let location = self.tapGesture.location(in: self.view)
        print(location)
    }

    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        let location = self.panGesture.location(in: self.view)
        print(location)
    }

    @objc func startAction(_ sender: UIBarButtonItem) {

    }

    @objc func resetAction(_ sender: UIBarButtonItem?) {

    }

    func randomSubViews() {
        self.view.subviews.forEach { $0.backgroundColor = UIColor.random(using: &Xoroshiro.default) }
    }

}
