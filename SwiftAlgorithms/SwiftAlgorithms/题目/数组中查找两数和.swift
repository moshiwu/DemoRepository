//
//  数组中查找两数和.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2020/1/12.
//  Copyright © 2020 莫锹文. All rights reserved.
//

import Foundation

/// 思路：遍历数组，以当前值和查找值之间的差为Key，以当前值索引为Value存进字典
private func findTotal(_ total: Int, in array: [Int]) -> [(Int, Int)] {
    var dict: [Int: Int] = [:]
    var result: [(Int, Int)] = []

    for index in 0 ..< array.count {
        let value = array[index]
        if let otherIndex = dict[total - value] {
            result.append((index, otherIndex))
        } else {
            dict[value] = index
        }

        // 一样
//        if let otherIndex = dict[value] {
//            result.append((index, otherIndex))
//        } else {
//            dict[total - value] = index
//        }
    }
    return result
}
