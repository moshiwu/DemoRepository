
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

enum TableViewEditingCommand {
    case donothing
    case deleteUser(indexPath: IndexPath)
    case moveUser(from: IndexPath, to: IndexPath)
}
print(type(of: TableViewEditingCommand.donothing))
print(type(of: TableViewEditingCommand.deleteUser))
print(type(of: TableViewEditingCommand.moveUser))

