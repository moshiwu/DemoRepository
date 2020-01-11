//
//  CountingSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/30.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 计数排序
/// 算法上要求元素必须是整数
/// 下面的写法能兼容负数，但时间复杂度会变差
///
/// 时间复杂度：
/// 平均：O(n+k)
/// 最好：O(n+k)
/// 最坏：O(n+k)
///

extension Array where Element == Int {
    mutating func countingSort() {
        if count <= 1 {
            return
        }

        var min: Int = 0
        var max: Int = 0

        for value in self {
            min = min < value ? min : value
            max = max > value ? max : value
        }

        countingSortHelper(&self, minValue: min, maxValue: max)
    }

    func countingSorted() -> [Element] {
        var array = self
        array.countingSort()
        return array
    }

    private func countingSortHelper(_ array: inout [Int], minValue: Int, maxValue: Int) {
        // 如果使用Hash表的话，就是桶排序？
        var bucket = Array<Int>.init(repeating: 0, count: abs(minValue) + maxValue + 1)
        var sortedIndex = 0
        let arrLen = array.count
        let bucketLen = abs(minValue) + maxValue + 1

        if minValue < 0 {
            array = array.map { $0 - minValue }
        }

        for i in 0 ..< arrLen {
            let value = array[i]
            bucket[value] += 1
        }

        for i in 0 ..< bucketLen {
            while bucket[i] > 0 {
                array[sortedIndex] = i
                sortedIndex += 1
                bucket[i] -= 1
            }
        }

        if minValue < 0 {
            array = array.map { $0 + minValue }
        }
    }
}
