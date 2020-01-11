//
//  SelectionSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 选择排序
///
/// 时间复杂度：
/// 平均：O(n²)
/// 最好：O(n²)
/// 最坏：O(n²)
///
/// PS.最好最坏都需要遍历两层
///

extension Array where Element: Comparable {
    mutating func selectionSort() {
        let len = count
        var minIndex: Int = 0

        for i in 0 ..< len {
            minIndex = i

            for j in (i + 1) ..< len where self[j] < self[minIndex] {
                minIndex = j
            }

            unsafe_swap(minIndex, i)
        }
    }

    func selectionSorted() -> [Element] {
        var array = self
        array.selectionSort()
        return array
    }
}
