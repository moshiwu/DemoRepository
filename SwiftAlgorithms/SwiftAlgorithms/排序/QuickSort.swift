//
//  QuickSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 快速排序
///
/// 时间复杂度：
/// 平均：O(nlogn)
/// 最好：O(nlogn)    
/// 最坏：O(n²)       数组刚好顺序的时候（即等于排序结果）
///

extension Array where Element: Comparable {
    mutating func quickSort1() {
        quickSort1Helper(array: &self, start: 0, end: count - 1)
    }

    func quickSorted1() -> [Element] {
        var array = self
        array.quickSort1()
        return array
    }

    mutating func quickSort2() {
        quickSort2Helper(array: &self, start: 0, end: count - 1)
    }

    func quickSorted2() -> [Element] {
        var array = self
        array.quickSort2()
        return array
    }

    func quickSort1Helper(array: inout [Element], start: Int, end: Int) {
        if start > end {
            return
        }

        let value = array[start]
        var left = start + 1
        var right = end

        while true {
            while left <= end, array[left] < value {
                left += 1
            }

            while right > left, array[right] >= value {
                right -= 1
            }

            if left > right { break }

            array.unsafe_swap(left, right)
            left += 1
            right -= 1
        }

        array.unsafe_swap(start, right)

        quickSort1Helper(array: &array, start: start, end: right - 1)
        quickSort1Helper(array: &array, start: right + 1, end: end)
    }

    func quickSort2Helper(array: inout [Element], start: Int, end: Int) {
        if start > end {
            return
        }

        let value = array[start]
        var i = start
        var j = end

        while i < j {
            while i < j, array[j] >= value {
                j -= 1
            }

            array.unsafe_swap(i, j)

            while i < j, array[i] <= value {
                i += 1
            }

            array.unsafe_swap(i, j)
        }

        quickSort2Helper(array: &array, start: start, end: j - 1)
        quickSort2Helper(array: &array, start: j + 1, end: end)
    }
}
