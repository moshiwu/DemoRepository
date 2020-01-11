//
//  InsertionSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 插入排序
///
/// 时间复杂度：
/// 平均：O(n²)
/// 最好：O(n)    数组顺序的时候
/// 最坏：O(n²)   数组逆序的时候
///

extension Array where Element: Comparable {
    mutating func insertionSort() {
        var index = 0
        var value: Element!

        for i in 1 ..< count {
            index = i - 1
            value = self[i]

            while index >= 0, self[index] > value {
                self[index + 1] = self[index]
                index -= 1
            }

            self[index + 1] = value
        }
    }

    func insertionSorted() -> [Element] {
        var array = self
        array.insertionSort()
        return array
    }
}
