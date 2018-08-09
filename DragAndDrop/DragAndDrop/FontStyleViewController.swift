//
//  FontStyleViewController.swift
//  DragAndDrop
//
//  Created by 莫锹文 on 2017/8/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import MobileCoreServices
import UIKit

class FontStyleViewController: UITableViewController {

    let fontNames = UIFont.familyNames.sorted()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.tableView.dragDelegate = self
        
        //test1
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fontNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontStyleCell", for: indexPath)

        let fontName = fontNames[indexPath.row]
        cell.textLabel?.text = fontName
        cell.textLabel?.font = UIFont(name: fontName, size: 18)

        return cell
    }
}

extension FontStyleViewController: UITableViewDragDelegate {
    public func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let fontName = fontNames[indexPath.row]
        
        // 1.简单将String当成Object传递
        //        let provider = NSItemProvider(object: fontName as NSString)

        // 2.把对象封装成NSData再传递，需要指明UTI类型（MobileCoreServices里）
        //let provider = NSItemProvider(item: fontName.data(using: .utf8)! as NSData, typeIdentifier: "随便一个id是不行的")  //错误示范
        let provider = NSItemProvider(item: fontName.data(using: .utf8)! as NSData, typeIdentifier: kUTTypePlainText as String)

        let dragItem = UIDragItem(itemProvider: provider)
        return [dragItem]
    }
}
