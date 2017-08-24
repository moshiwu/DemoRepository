//
//  ViewController.swift
//  RxCocoaDemo
//
//  Created by 莫锹文 on 2017/8/22.
//

import UIKit
import RxCocoa
import SwiftLiteKit
import RxSwift

typealias ValidationResult = (valid: Bool?, message: String?)

class RegisterViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!

    @IBOutlet weak var btn_commit: UIButton!
    let bag = DisposeBag()
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var tf_password_confirm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 定义一个类似于开关的Observable，作为下面sample operator的开关，作用是如果用户名长度少于等于20的时候，每次输入都触发一次usernameSign，如果大于20，则sampleSign不发送信号，从而usernameSign也不触发信号
        let sampleSign = tf.rx.text.filter { $0!.count <= 20 }

        // 定义用户名的信号
        let usernameSign = tf.rx.text
            .sample(sampleSign) // 如上
            .filter { $0 != "" } // 过滤用户名为空的情况
            .distinctUntilChanged { $0 == $1 } // 当两次信号之间内容有改变，发送新信号
            .debounce(1, scheduler: MainScheduler.instance) // 无输入操作1秒后，才发送下一步信号，防止每次输入都请求网络验证，浪费资源
            .map { [unowned self] username in self.validateUsername(username) } // 映射变换，把用户名信号转换为ValidationResult信号
            .switchLatest() // map operator 返回的对象如果是Observable，那么返回的信号流会是散发的（即异步导致不同信号到达流的时间可能不同），switch系列operator的作用就是把这些信号给碾平整（http://reactivex.io/documentation/operators/switch.html）
            .shareReplay(1) // 假如usernameSign被订阅多次，用share系列operator可以避免重复信号流变换过程执行的操作（这里例子就是：如果没有share，每次会usernameSign被订阅，都会重复执行上面的sample、filter、map等里面的closure）
        //            .debug()

        // usernameSign的第一个订阅，用来改变label1的文字
        _ = usernameSign
            .subscribe(
                onNext: { [weak self] valid, _ in
                    guard let isValid = valid else {
                        self?.label1.text = "验证中..."
                        return
                    }

                    self?.label1.text = isValid ? "账号可用" : "账号已存在"
                }
            )
            .addDisposableTo(bag)

        // 单独订阅tf.rx.text，用来限制输入的长度
        _ = tf.rx.text
            .filter { $0!.count > 20 }
            .subscribe { [weak self] in
                self?.tf.text = self?.tf.text?.substring(to: 20)
                print("用户名输入长度大于10 \($0)")
            }
            .addDisposableTo(bag)

        // 第一个密码textField
        _ = tf_password.rx.text
            .skip(1) // 跳过界面刚初始化的第一个信号
            .debounce(0.2, scheduler: MainScheduler.instance)
            .map { [unowned self] value in self.validatePassword(password: value!) } // 将字符串验证并映射为ValidationResult
            .map { return $0.valid! } // 再将ValidationResult映射为Bool
            .subscribe(onNext: { [weak self] in self?.label2.text = $0 ? "ok" : "输入正确格式" })

        // 将密码的两个textField的observable串联起来
        let repeatPasswordSign = Observable
            .combineLatest([tf_password.rx.text, tf_password_confirm.rx.text]) // 取每个observable中最新的合并成数组
            .distinctUntilChanged { $0.elementsEqual($1, by: ==) } // 同上面的distinctUntilChanged，但这里有个bug(?)，如果返回true，那么上一次的值不会更新到下一次的oldValue（参数的$0）里
            .map({ [unowned self] (array: [String?]) in
                self.validateRepeatedPassword(password: array[0]!, repeatedPassword: array[1]!) // 注意这里返回的直接是ValidationResult，而不是Observable<ValidationResult>，所以不会导致散发(emits)，不能使用switch operator
            })

        //        _ = repeatPasswordSign.subscribe { print("repeatPasswordSign : \($0)") }

        _ = repeatPasswordSign
            .skip(1)
            .map { return $0.valid! } // 再将ValidationResult映射为Bool
            .subscribe(onNext: { [weak self] in self?.label3.text = $0 ? "ok" : "两次密码不相同" })

        _ = Observable.combineLatest([usernameSign, repeatPasswordSign])
            .map({ (array: [ValidationResult]) in
                (array[0].valid ?? false) && (array[1].valid ?? false)
            })
            .debug()
            .subscribe(onNext: { [weak self] in
                print("检查按钮是否可以点击 : \($0)")
                self?.btn_commit.isEnabled = $0
            })
            .addDisposableTo(bag)

    }

    @IBAction func onTouch(_ sender: Any) {
        API.register()
            .subscribe(
                onNext: { print($0 ? "登陆成功" : "登陆失败") },
                onDisposed: { print("register observable disposed") }
            )
            .addDisposableTo(bag)
    }

    func validateUsername(_ unwarppedUsername: String?) -> Observable<ValidationResult> {
        guard let username = unwarppedUsername else {
            return Observable<ValidationResult>.just((false, nil))
        }

        // 如果用户名为空
        if username.characters.count == 0 {
            return Observable<ValidationResult>.just((false, nil))
        }

        // 如果用户名中出现非法字符

        if username.rangeOfCharacter(from: NSCharacterSet.alphanumerics.inverted) != nil {
            return Observable<ValidationResult>.just((false, "Username can only contain numbers or digits"))
        }

        // 加载中的值
        //        let loadingValue = (valid: nil as Bool?, message: "Checking availabilty ..." as String?)

        // 校验用户名
        return API.usernameAvailable(username)
            .map { available in
                if available {
                    return (true, "Username available")
                } else {
                    return (false, "Username already taken")
                }
            }
        //            .startWith(loadingValue) // 在加载结果之前插入 加载中 这个状态的事件值
    }

    func validatePassword(password: String) -> ValidationResult {
        let numberOfCharacters = password.characters.count
        if numberOfCharacters == 0 {
            return (false, nil)
        }

        if numberOfCharacters < 6 {
            return (false, "Password must be at least \(6) characters")
        }

        return (true, "Password acceptable")
    }

    func validateRepeatedPassword(password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.characters.count == 0 {
            return (false, nil)
        }

        if repeatedPassword == password {
            return (true, "Password repeated")
        } else {
            return (false, "Password different")
        }
    }

    deinit {
        print("RegisterViewController deinit")
    }
}

class API {
    static var session = URLSession(configuration: .default)
    public class func usernameAvailable(_ value: String) -> Observable<Bool> {

        let url = URL(string: "https://github.com/\(value)")!
        let request = URLRequest(url: url)

        return session.rx.response(request: request)
            .map { httpResponse, _ in
                httpResponse.statusCode == 404
            }
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(false)
    }

    static var i = 0
    /// 模拟登陆
    public class func register() -> Observable<Bool> {
        return Observable<Bool>.create({ (observer) -> Disposable in
            observer.onNext(i % 2 == 0)
            i += 1
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
