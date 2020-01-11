//
//  BubbleSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 冒泡排序
///
/// 时间复杂度：
/// 平均：O(n²)
/// 最好：O(n)    数组顺序的时候
/// 最坏：O(n²)   数组逆序的时候
///

extension Array where Element: Comparable {
    mutating func bubbleSort() {
        let len = count

        for i in 0 ..< len - 1 {
            for j in 0 ..< len - 1 - i {
                if self[j] > self[j + 1] {
                    unsafe_swap(j, j + 1)
                }
            }
        }
    }

    func bubbleSorted() -> [Element] {
        var array = self
        let len = array.count

        for i in 0 ..< len - 1 {
            for j in 0 ..< len - 1 - i {
                if array[j] > array[j + 1] {
                    array.unsafe_swap(j, j + 1)
                }
            }
        }

        return array
    }
}
