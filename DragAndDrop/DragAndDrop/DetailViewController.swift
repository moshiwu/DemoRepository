//
//  ViewController.swift
//  DragAndDrop
//
//  Created by 莫锹文 on 2017/8/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var colorCollection: UICollectionView!

    var titleColor: UIColor = UIColor.red
    var titleFont: String = "Arial"
    var titleImage: UIImage?

    let colors: [UIColor] = {
        let colorIndex: [CGFloat] = [0, 51 / 255, 102 / 255, 153 / 255, 204 / 255, 1]

        var temp = [UIColor]()
        for i in colorIndex {
            for j in colorIndex {
                for k in colorIndex {
                    temp.append(UIColor(red: i, green: j, blue: k, alpha: 1))
                }
            }
        }

        return temp.reversed()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.colorCollection.dragDelegate = self
        
        poster.isUserInteractionEnabled = true
        poster.addInteraction(UIDropInteraction(delegate: self))
        
        drawBoard()
    }

    func drawBoard() {
        
        self.label.font = UIFont(name: titleFont, size: 30)
        self.label.text = "Drag And Drop Here."
        
        self.poster.backgroundColor = self.titleColor
        self.poster.image = self.titleImage
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)

        cell.backgroundColor = colors[indexPath.item]
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 6

        return cell
    }
}

extension DetailViewController: UICollectionViewDragDelegate {
    public func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let color = colors[indexPath.item]
        let provider = NSItemProvider(object: color)
        let dragItem = UIDragItem(itemProvider: provider)

        return [dragItem]
    }
}

extension DetailViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction,
                         performDrop session: UIDropSession) {
        let location = session.location(in: poster)

        session.loadObjects(ofClass: UIColor.self, completion: {
            guard let color = $0.first as? UIColor else { return }

            if location.y < self.poster.bounds.maxY {
                print("drop color")

                self.titleColor = color
                self.drawBoard()
            }
        })
        
        session.loadObjects(ofClass: NSString.self, completion: {
            guard let string = $0.first as? NSString else { return }
            
            if location.y < self.poster.bounds.maxY
            {
                print("drop font")
                self.titleFont = string as String
                self.drawBoard()
            }
        })
        
        if session.hasItemsConforming(toTypeIdentifiers: ["随便一个id是不行的"])
        {
            print("测试随便的id是否可行")
        }
        
        if session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String])
        {
            session.loadObjects(ofClass: UIImage.self, completion: {
                guard let image = $0.first as? UIImage else { return }
                
                if location.y < self.poster.bounds.maxY
                {
                    self.titleImage = image
                    self.drawBoard()
                }
                
                
            })
        }
    }

}
