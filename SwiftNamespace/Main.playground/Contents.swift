//: Playground - noun: a place where people can play

import UIKit

// 要点：
// 1. 同名泛型可以省略
// 2. 如果实际使用的类已定义泛型的实现，那么也可以省略
// 3. 类似RxSwift、Snapkit、Kingfisher里避免方法命名冲突的具体实现方法
// 4. 例子里面的定义的Key、Value、Element原意是为了实现扩展带泛型的class/struct而添加的，但是这样做会导致两个问题：
//    ①. 不需要用到的泛型也需要typealias，
//    ②. 会导致xxxx.kf会被其他扩展方法污染，如下面例子里Dict能用到其他扩展的方法（虽然会报错）

public final class SomeKit<Base, Key, Value, Element> where Key: Hashable {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SomeKitCompatible {
    associatedtype CompatibleType
    associatedtype Key: Hashable
    associatedtype Value
    associatedtype Element
    var sk: SomeKit<CompatibleType, Key, Value, Element> { get }
}

public extension SomeKitCompatible {
    public var sk: SomeKit<Self, Key, Value, Element> { return SomeKit(self) }
}

// MARK: 无泛型

extension NSObject: SomeKitCompatible {
    public typealias Key = NSObject
    public typealias Value = NSObject
    public typealias Element = NSObject
}

extension SomeKit where Base == NSObject {
    public func traceObject() {
        print(Base.self)
    }
}

let object1 = NSObject()
object1.sk.traceObject()

// MARK: 单个泛型

public struct TestStruct<T> where T: Hashable {
    public func trace() {
        print(T.self)
    }
}

extension TestStruct: SomeKitCompatible {
    public typealias Element = T
    public typealias Key = T
    public typealias Value = T
}

extension SomeKit where Base == TestStruct<Key> {
    public func traceSingleGeneric() {
        print(Base.self)
    }
}

let object2 = TestStruct<String>()
object2.sk.traceSingleGeneric()
print(type(of: object2.sk))

// MARK: Array(一个泛型，Element同名）

extension Array: SomeKitCompatible {
    public typealias Key = AnyHashable
    public typealias Value = AnyObject
}

extension SomeKit where Base == Array<Element> {
    public func traceArray() {
        print(Base.self)
    }
}

let array = [1, 2, 3]
array.sk.traceArray()
print(type(of: array.sk))

// MARK: Dictionary(两个泛型，Key、Value同名)

extension Dictionary: SomeKitCompatible {
    // 因为同名，所以以下代码可以省略
    // public typealias Key = Dictionary.Key
    // public typealias Value = Dictionary.Value

    // 因为Dictionary里面已定义，所以Element也可以省略
    // public typealias Element = (key: Key, value: Value)
}

extension SomeKit where Base == Dictionary<Key, Value> {
    public func traceDictionary() {
        print(Base.self)
    }
}

let dict: Dictionary<String, String> = ["111": "222"]
dict.sk.traceDictionary()
print(type(of: dict.sk))

// 方法污染，代码提示有反应，但会报错
// dict.sk.traceObject()
// dict.sk.traceArray()
// dict.sk.traceSingleGeneric()
