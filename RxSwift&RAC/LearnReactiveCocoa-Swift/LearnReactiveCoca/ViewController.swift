//
//  ViewController.swift
//  LearnReactiveCoca
//
//  Created by 莫锹文 on 2016/11/10.
//  Copyright © 2016年 莫锹文. All rights reserved.
//

import UIKit
import ReactiveSwift

class ViewController: UIViewController {

    var dispoable: Disposable?

    override func viewDidLoad() {
        super.viewDidLoad()

        let (signal, observer) = Signal<Int, NSError>.pipe()

        let subscriber1: Observer<Int, NSError> = Observer { print("Subscriber 1 received \($0)") }
        let subscriber2: Observer<Int, NSError> = Observer { print("Subscriber 2 received \($0)") }

        self.dispoable = signal.observe(subscriber1)
        
        print("Subscriber 1 subscribes to the signal")
        print("Send value `10` on the signal")
        observer.send(value: 10)
        
        print("Subscriber 2 subscribes to the signal")
        signal.observe(subscriber2)
        observer.send(value: 20)

        print(self.dispoable!)

        // 基本用法
        let dispos = ActionDisposable { print("action disposable") }
        var obs: Observer<String, NSError>! // 监听器
        let signalA = Signal<String, NSError> { (ob) -> Disposable? in
            obs = ob
            return dispos
        }

        // 监听事件
        signalA.observe { (event: Event<String, NSError>) in
            switch event {
            case .value(let value):
                print("value:", value)
            case .failed(let error):
                print(error)
            case .completed:
                print("completed")
            case .interrupted:
                print("interrupted")
            }
        }

        // 发送事件
        obs.send(value: "ABC")
        obs.send(value: "DDD")
        obs.send(value: "ffD")
        obs.sendCompleted()
        
        
        let observer:Observer<Int,NSError> = Observer()
        
        

    }

}
