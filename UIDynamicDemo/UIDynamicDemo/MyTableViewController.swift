//
//  MyTableViewController.swift
//  UIDynamicDemo
//
//  Created by 莫锹文 on 2017/9/1.
//  Copyright © 2017年 莫锹文. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    lazy var titles = [
        "测试1",
        "测试2",
        "测试3",
        "测试4",
        "测试5",
        "测试6",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseId")

    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId")
        cell!.textLabel!.text = titles[indexPath.row]
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var vc: UIViewController?

        let index = indexPath.row + 1
        if index == 1 {
            vc = Demo1ViewController()
        } else if index == 2 {
            vc = Demo2ViewController()
        } else if index == 3 {
            vc = Demo3ViewController()
        } else if index == 4 {
            vc = Demo4ViewController()
        } else if index == 5 {
            vc = Demo5ViewController()
        }

        guard let v = vc else { return }
        self.navigationController?.pushViewController(v, animated: true)
    }
}
