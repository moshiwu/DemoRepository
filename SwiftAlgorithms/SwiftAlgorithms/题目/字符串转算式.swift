//
//  字符串转算式.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2020/1/11.
//  Copyright © 2020 莫锹文. All rights reserved.
//

import Foundation

// 除法只考虑整除，不考虑被除数为0

private let str = "1*(2+3)+8/(1+3)+6*(8-4)"

private func counting(_ str: String) -> Int {
    var str = str
    if str.hasPrefix("("), str.hasSuffix(")"), str.firstIndex(of: "(") == str.lastIndex(of: "(") {
        str.removeFirst()
        str.removeLast()
    }

    if !str.contains("+"), !str.contains("-"), !str.contains("*"), !str.contains("/") {
        return Int(str)!
    }

    var op = ""
    var count = 0
    let array = Array(str)
    var left: String = ""
    var right: String = ""

    // 第一次遍历，分割 + 和 -
    for i in 0 ..< array.count {
        let element = array[i]
        if element == "(" {
            count += 1
        }
        if element == ")" {
            count -= 1
        }

        if count == 0, element == "+" || element == "-" {
            op = String(element)

            left = array[0 ..< i].map { String($0) }.joined()
            right = array[i + 1 ..< array.count].map { String($0) }.joined()
            break
        }
    }

    if op.isEmpty {
        // 第一次遍历，分割 * 和 /
        for i in 0 ..< array.count {
            let element = array[i]
            if element == "(" {
                count += 1
            }
            if element == ")" {
                count -= 1
            }

            if count == 0, element == "*" || element == "/" {
                op = String(element)
                left = array[0 ..< i].map { String($0) }.joined()
                right = array[i + 1 ..< array.count].map { String($0) }.joined()
                break
            }
        }
    }

    if op == "+" {
        return counting(left) + counting(right)
    } else if op == "-" {
        return counting(left) - counting(right)
    } else if op == "*" {
        return counting(left) * counting(right)
    } else if op == "/" {
        return counting(left) / counting(right)
    }

    return 0
}
