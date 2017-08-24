
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import RxSwift
import RxCocoa
import SwiftLiteKit

func delay(_ delay: TimeInterval, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: closure)
}

func stamp() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter.string(from: date)
}

func writeSequenceToConsole<O: ObservableType>(name: String, sequence: O) {
    sequence
        .subscribe { e in
            print("Subscription: \(name), event: \(e)")
        }
}

// let arr1: [String?] = ["1", "2", "3", "4"]
// let arr2: [String?] = ["1", "2", "3", "4"]
//
// print(arr1)
// print(arr2)
//
// arr1.elementsEqual(arr2, by: == )
//
// print(arr1)
// print(arr2)

// let sequenceOfElements = Observable.of(1,2,3,4).map { r -> Int in
//    print("MAP")    // twice
//    return r * 2
// }.share()
//
//
// let subscription = sequenceOfElements
//    .subscribe { event in
//        print("1 - \(event)")
// }
// let subscription2 = sequenceOfElements
//    .subscribe { event in
//        print("2 - \(event)")
//
