//
//  ViewController.swift
//  RxCocoaDemo
//
//  Created by 莫锹文 on 2017/9/5.
//

import UIKit
import Alamofire
import APPSNetworking
import AlamofireObjectMapper
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    lazy var bag = DisposeBag()

    var loginObservable: Observable<APPSLoginResponse>?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func testAction(_ sender: Any) {
        let model = APPSLoginRequestModel()
        model.accountId = "msw1000@qq.com"
        model.password = "111111"
        model.customerCode = "L90"

        APPSNetworking.logLevel = .none

        var array = [Observable<APPSLoginResponse>]()

        for _ in 0...30 {
            let request1: Observable<APPSLoginResponse> = APPSNetworking.rx.startRequest(requestModel: model)
            array.append(request1)
        }

        Observable.combineLatest(array).subscribe({ print($0) }).disposed(by: bag)

    }

}
