//
//  ViewController.swift
//  SwiftiOSApp
//
//  Created by 莫锹文 on 2018/11/15.
//  Copyright © 2018 莫锹文. All rights reserved.
//

import Closures
import JRSwizzle
import SnapKit
import SwiftLiteKit
import TYPagerController
import UIKit
import YYKit

let key = "canScroll".unsafeMutableRawPointer()!

extension UIScrollView: PointerPrinter {
    // 1. 增加一个属性，控制是否能滑动
    @objc var canScroll: Bool {
        get {
            guard let number = self.getAssociatedValue(forKey: key) as? NSNumber else {
                return true
            }
            
            return number.boolValue
        }
        set {
            self.setAssociateValue(NSNumber(value: newValue), withKey: key)
        }
    }
    
    // 2. runtime替换，根据canScroll处理handlePan:
    @objc dynamic func s_handlePan(_ gesture: UIGestureRecognizer) {
        if self.canScroll {
            self.s_handlePan(gesture)
        }
    }
}

class MyCollectionView: UICollectionView, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    // 3. 关键点：让多个手势共存
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // PS. 实际用的时候，需要判断otherGestureRecognizer是什么手势
    }
}

class View1: UIScrollView, UIGestureRecognizerDelegate {
    var collectionView: MyCollectionView!
    
    weak var bindPagerView: TYPagerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = MyCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .green
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "id")
        collectionView
//            .willBeginDragging(handler: {
//                self.bindPagerView?.scrollView.canScroll = false
//                print("willBeginDragging \($0.isTracking) \($0.isDragging) \($0.isDecelerating) \(self.bindPagerView!.scrollView.canScroll)")
//
//            })
            .didEndDragging(handler: { _, willDecelerate in
                print("didEndDragging")
                // 4. 非减速的情况
                if !willDecelerate {
                    self.bindPagerView?.scrollView.canScroll = true
                }
            })
            .willBeginDecelerating(handler: { _ in
                print("willBeginDecelerating")
            })
            .didEndDecelerating(handler: {
                print("didEndDecelerating \($0.isTracking) \($0.isDragging) \($0.isDecelerating)")
                // 5. 减速结束
                self.bindPagerView?.scrollView.canScroll = true
            })
            .didScroll(handler: { _ in
                
                // 6. 根据offset判断外层UIScrollview可否滑动
                let canScroll = self.collectionView.contentSize.width - self.collectionView.frame.width <= self.collectionView.contentOffset.x
                let scrollView = self.collectionView!
                
                self.bindPagerView?.scrollView.canScroll = canScroll
                
                // 7. 额外处理
                if scrollView.isTracking && !canScroll {
                    self.bindPagerView?.scrollView.setContentOffset(.zero, animated: false)
                }
            })
            .didEndScrollingAnimation(handler: { _ in
                print("didEndScrollingAnimation")
            })
            .numberOfItemsInSection { _ in 5 }
            .sizeForItemAt(handler: { _ in CGSize(width: 180, height: 180) })
            .cellForItemAt {
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: $0)
                cell.backgroundColor = .cyan
                return cell
            }
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.top.equalTo(200)
        }
        
        self.contentSize = CGSize(width: 0, height: 1000)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController, TYPagerViewDelegate, TYPagerViewDataSource {
    var view1: View1!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageView = TYPagerView()
        pageView.delegate = self
        pageView.dataSource = self
        pageView.scrollView.bounces = false
        self.view.addSubview(pageView)
        pageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    @objc func injected() {
        children.forEach { $0.removeFromParent() }
        self.viewDidLoad()
        print("injected")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    func numberOfViewsInPagerView() -> Int {
        return 3
    }
    
    func pagerView(_ pagerView: TYPagerView, viewFor index: Int, prefetching: Bool) -> UIView {
        if index == 0 {
            self.view1 = View1()
            self.view1.backgroundColor = .red
            self.view1.bindPagerView = pagerView
            return self.view1
        } else {
            let v = UIView()
            v.backgroundColor = .yellow
            return v
        }
    }
    
    func pagerViewDidScroll(_ pageView: TYPagerView) {
//        print(pageView.scrollView.canScroll)
    }
}
