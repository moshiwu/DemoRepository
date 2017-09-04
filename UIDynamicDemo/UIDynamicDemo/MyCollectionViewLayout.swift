//
//  MyCollectionViewLayout.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit

class MyCollectionViewLayout: UICollectionViewFlowLayout {
    
    var animator: UIDynamicAnimator!
    
    override func prepare() {
        super.prepare()
        
        if animator == nil {
            animator = UIDynamicAnimator(collectionViewLayout: self)
            
            let size = collectionViewContentSize
            guard let items = super.layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: size.width, height: size.height)) else { return }
            
            for item in items {
                let spring = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                
                spring.length = 0
                spring.damping = 0.8
                spring.frequency = 0.8
                animator.addBehavior(spring)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return animator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return animator.layoutAttributesForCell(at: indexPath)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        let scrollDelta = Float(newBounds.minY - collectionView!.bounds.origin.y)
        
        let touchLocation = collectionView!.panGestureRecognizer.location(in: collectionView!)
        
        for spring in animator.behaviors as! [UIAttachmentBehavior] {
            let anchorPoint = spring.anchorPoint
            let distanceFromTouch = fabsf(Float(touchLocation.y - anchorPoint.y))
            let scrollResistance = Float(distanceFromTouch / 500)
            
            let item = spring.items.first
            var center = item?.center
            
            let value = (scrollDelta > 0) ? min(scrollDelta, scrollDelta * scrollResistance) : max(scrollDelta, scrollResistance * scrollResistance)
            center?.y += CGFloat(value)
            item?.center = center!
            animator.updateItem(usingCurrentState: item!)
        }
        
        return false
    }
}
