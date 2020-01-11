//
//  ShellSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 希尔排序
///
/// 时间复杂度：
/// 平均：O(n²)
/// 最好：O(n)    数组顺序的时候
/// 最坏：O(n²)   数组逆序的时候
///

extension Array where Element: Comparable {
    mutating func shellSort() {
        var gap = count / 2

        while gap > 0 {
            for i in gap ..< count {
                var j = i
                let current = self[i]

                while j - gap >= 0, current < self[j - gap] {
                    self[j] = self[j - gap]
                    j = j - gap
                }
                self[j] = current
            }

            gap = gap / 2
        }
    }

    func shellSorted() -> [Element] {
        var array = self
        array.shellSort()
        return array
    }
}
