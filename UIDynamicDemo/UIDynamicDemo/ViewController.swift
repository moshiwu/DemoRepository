//
//  ViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit
import RandomKit
import SwiftLiteKit

class ViewController: UIViewController {

    let reuseId = "reuseId"
    var layout: MyCollectionViewLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout = MyCollectionViewLayout()
        self.layout.itemSize = CGSize(width: self.view.frame.width, height: 44)

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseId)
        self.view.addSubview(collectionView)

    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
        cell.contentView.backgroundColor = UIColor.random(using: &Xoroshiro.default)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }

}
