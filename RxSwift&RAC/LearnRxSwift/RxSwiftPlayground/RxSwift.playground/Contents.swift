import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import RxSwift
import RxCocoa
import SwiftLiteKit
import RandomKit

public func example(_ description: String, action: () -> ()) {
    printExampleHeader(description)
    action()
}

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) example ---")
}

func delay(_ delay: TimeInterval, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: closure)
}

func stamp() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter.string(from: date)
}

extension Observable {
    public func addObserver(_ value: String) -> Disposable {
        return self.asObservable().subscribe { print("Subscription \(value) Event : \($0)") }
    }
}
//
// Observable<Int>
//    .interval(1, scheduler: MainScheduler.instance)
//    .buffer(timeSpan: 10, count: 2, scheduler: MainScheduler.instance)
//    .subscribe{ print($0) }
//
//// Observable<Int>.timer(0, period: 0.3, scheduler: MainScheduler.instance).subscribe{ print($0) }

// example("window")
// {
////    periodically subdivide items from an Observable into Observable windows and emit these windows rather than emitting the items one at a time
////    周期性地把Observable发射的元素，包装到Observable windows里再发射。如果元素个数在一个周期内超出指定的上限，则会马上发射并进入下一个周期
//
//    Observable<Int>
//        .interval(1, scheduler: MainScheduler.instance)
////        .window(timeSpan: 5, count: 2, scheduler: MainScheduler.instance) //更换count能看出区别
//        .window(timeSpan: 5, count: 20, scheduler: MainScheduler.instance)
//        .subscribe(
//            onNext: {
//                print("window open")
//                $0.subscribe(
//                    onNext: { print("sub subscribe \($0)") },
//                    onCompleted: { print("window close") }
//                )
//            }
//        )
// }

// example("debounce & throttle")
// {
//    let r1 = 10..<16
//    let r2 = 30..<36
//
//    Observable<Int>
//        .interval(1, scheduler: MainScheduler.instance)
//        .subscribe({ print($0) })
//
//    Observable<Int>
//        .interval(1, scheduler: MainScheduler.instance)
//        .filter { !(r1.contains($0) || r2.contains($0)) }
//        //            .debounce(5, scheduler: MainScheduler.instance)   // 收到发射第一个元素的请求后，一定时间周期内如果没有新的元素发射请求，就会发射最新的元素。（第一个元素不会发射）
//        .throttle(5, scheduler: MainScheduler.instance) // 一定时间周期内只会发射一个元素，并且只会发射最新的元素。（第一个元素会立即发射）
//        .addObserver("debounce & throttle")
// }

// example("distinctUntilChanged")
// {
//    let obserable = Observable<Int>
//        .interval(0.5, scheduler: MainScheduler.instance)
//        .map { $0 / 5 }
//
//    obserable
//        .addObserver("for compare")
//
//    obserable
//        .distinctUntilChanged()
//        .addObserver("distinctUntilChanged")
// }

// example("sample")
// {
//    let source = PublishSubject<Int>()
//    let target = PublishSubject<String>()
//    let subscription = source
//        .sample(target)
//        .subscribe
//    { event in
//        print(event)
//    }
//    source.onNext(1)
//    target.onNext("A") // 获取最新的source
//    source.onNext(2)
//    source.onNext(3)
//    target.onNext("B") // 获取最新的source
//    target.onNext("C") // 没有最新的source，不发射
// }
//
//// given two or more source Observables, emit all of the items from only the first of these Observables to emit an item or notification
//// 在两个Observable中，只取第一个发射信号的Observable，并发射这个Observable的所有元素，忽略另一个Observable的所有元素
//
// example("amb")
// {
//    let subject1 = PublishSubject<Int>()
//    let subject2 = PublishSubject<Int>()
//
//    PublishSubject<Int>.amb([subject1, subject2]).subscribe { print($0) }
//
//    subject1.onNext(10)
//    subject2.onNext(20)
//
//    subject1.onNext(11)
//    subject2.onNext(21)
//
//    subject1.onNext(12)
//    subject2.onNext(22)
// }
//
//// - skipUntil : 忽略Observable发射的元素，直到另一个Observable开始发送元素
//// - skipWhile : 忽略Observable发射的元素，直到closure返回false
//// - takeUntil : 接收Observable发射的元素，直到另一个Observable开始发送元素
//// - takeWhile : 接收Observable发射的元素，直到closure返回false
// example("skipUntil & skipWhile & takeUntil & takeWhile")
// {
//    let subject1 = PublishSubject<Int>()
//    let subject2 = PublishSubject<String>()
//
//    subject1.skipUntil(subject2).addObserver("skipUntil")
//    subject1.skipWhile { $0 < 5 }.addObserver("\tskipWhile")
//    subject1.takeUntil(subject2).addObserver("takeUntil")
//    subject1.takeWhile { $0 < 5 }.addObserver("\ttakeWhile")
//
//    subject2.addObserver("---------")
//
//    subject1.onNext(1)
//    subject1.onNext(2)
//    subject1.onNext(3)
//    subject1.onNext(4)
//    subject2.onNext("分割线")
//    subject1.onNext(5)
//    subject1.onNext(6)
//    subject1.onNext(7)
//    subject1.onNext(8)
// }
//
//
////when an item is emitted by either of two Observables, combine the latest item emitted by each Observable via a specified function and emit items based on the results of this function
////Observable集合中，其中一个Observable发射元素，则取其他元素的最新的元素，组合起来并发射。如果有处理closure，则经过处理再发射
// example("combineLatest")
// {
//    let sub1 = PublishSubject<Int>()
//    let sub2 = PublishSubject<Int>()
//
//    PublishSubject<Int>
//        .combineLatest([sub1, sub2])
//        .addObserver("combineLatest")
//
//    PublishSubject<Int>
//        .combineLatest([sub1, sub2], { (array: [Int]) -> Int in
//            array.reduce(0, +)
//        })
//        .addObserver("combineLatest with closure")
//
//    sub1.onNext(1)
//    sub1.onNext(2)
//    sub1.onNext(3)
//    sub1.onNext(4)
//
//    sub2.onNext(21)
//    sub2.onNext(22)
//    sub2.onNext(23)
//    sub2.onNext(24)
//
//    sub1.onNext(5)
//    sub2.onNext(25)
// }

// example("switchLatest") {
//    let sub1 = PublishSubject<String>()
//    let sub2 = PublishSubject<String>()
//
//    let all = PublishSubject<PublishSubject<String>>()
//
//
//    all.switchLatest().addObserver("switchLatest")
//
//    all.onNext(sub1)
//
//    sub1.onNext("a")
//    sub1.onNext("b")
//
//    all.onNext(sub2)
//
//    sub1.onNext("c")
//    sub1.onNext("d")
//    sub1.onNext("e")
//
//    sub2.onNext("1")
//    sub2.onNext("2")
//    sub2.onNext("3")
//    sub2.onNext("4")
//    sub2.onNext("5")
// }

// enum TestError: Error
// {
//    case test
// }
// example("catch error")
// {
//    let sub1 = PublishSubject<String>()
//
//    sub1.onNext("a")
//    sub1.onNext("b")
//
//    sub1.onError(TestError.test)
//    sub1.onNext("c")
//    sub1.onNext("d")
//    sub1.onNext("e")
//
//    sub1.catchErrorJustReturn("catch an error").addObserver("catch error")
// }

// example("reduce")
// {
//    let sub = PublishSubject<Int>()
//
//    sub.reduce(0, accumulator: +).addObserver("reduce")
//    sub.scan(0, accumulator: +).addObserver("scan")
//    sub.onNext(3)
//    sub.onNext(4)
//    sub.onNext(5)
//    sub.onNext(6)
//    sub.onNext(7)
//
//    print("未发送完成就不会执行reduce")
//
//    sub.onCompleted()
// }

// example("delaySubscription")
// {
//    let sub = PublishSubject<Int>()
//
//    sub.delaySubscription(3, scheduler: MainScheduler.instance).addObserver("delaySubscription")
//
//    sub.onNext(3)
//    sub.onNext(4)
//    sub.onNext(5)
//    sub.onNext(6)
//    sub.onNext(7)
//
//    print("delay 3.5s ...")
//    delay(3.5, closure: {
//        print("after delay...")
//        sub.onNext(10)
//    })
// }

// example("timeout")
// {
//    let range = 10..<20
//    Observable<Int>
//        .never()
////        .interval(0.5, scheduler: MainScheduler.instance)
////        .filter{ !range.contains($0) }
//        .timeout(2, scheduler: MainScheduler.instance)
//        .addObserver("timeout")
//// }
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class NetworkRequest {
    class var sharedInstance: NetworkRequest {
        return NetworkRequestShareInstance
    }
}

private let NetworkRequestShareInstance = NetworkRequest()

extension NetworkRequest {
    // MARK: - GET 请求
    //    let tools : NetworkRequest.shareInstance!

    func getRequest(urlString: String, params: [String: Any], success: @escaping (_ response: [String: AnyObject]) -> (), failture: @escaping (_ error: Error) -> ()) {

        // 使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受           [String : AnyObject]类型 返回void类型的函数

        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { response in /* 这里使用了闭包 */
                // 当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                // 使用switch判断请求是否成功，也就是response的result
                switch response.result {
                case .success(let value):
                    // 当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                    //                    if let value = response.result.value as? [String: AnyObject] {
                    success(value as! [String: AnyObject])
                    //                    }
                    let json = JSON(value)
                    print(json)

                case .failure(let error):
                    failture(error)
                    print("error:\(error)")
                }
            }

    }
    // MARK: - POST 请求
    func postRequest(urlString: String, params: [String: Any], success: @escaping (_ response: [String: AnyObject]) -> (), failture: @escaping (_ error: Error) -> ()) {

        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                    let json = JSON(value)
                    (json)
                }
            case .failure(let error):
                failture(error)
                print("error:\(error)")
            }

        }
    }

    // MARK: - 照片上传
    ///
    /// - Parameters:
    ///   - urlString: 服务器地址
    ///   - params: ["flag":"","userId":""] - flag,userId 为必传参数
    ///        flag - 666 信息上传多张  －999 服务单上传  －000 头像上传
    ///   - data: image转换成Data
    ///   - name: fileName
    ///   - success:
    ///   - failture:
    func upLoadImageRequest(urlString: String, params: [String: String], data: [Data], name: [String], success: @escaping (_ response: [String: AnyObject]) -> (), failture: @escaping (_ error: Error) -> ()) {

        let headers = ["content-type": "multipart/form-data"]

        Alamofire.upload(
            multipartFormData: { multipartFormData in
                // 666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]

                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append((userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")

                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
            },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject] {
                            success(value)
                            let json = JSON(value)
                            print(json)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    failture(encodingError)
                }
            }
        )
        
        Alamofire.upload(multipartFormData: <#T##(MultipartFormData) -> Void#>, usingThreshold: <#T##UInt64#>, to: <#T##URLConvertible#>, method: <#T##HTTPMethod#>, headers: <#T##HTTPHeaders?#>, encodingCompletion: <#T##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##(SessionManager.MultipartFormDataEncodingResult) -> Void#>)
    }
}
