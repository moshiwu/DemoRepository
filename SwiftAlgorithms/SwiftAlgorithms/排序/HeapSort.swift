//
//  HeapSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/30.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 堆排序
///
/// 时间复杂度：
/// 平均：O(nlogn)
/// 最好：O(nlogn)
/// 最坏：O(nlogn)
///

extension Array where Element: Comparable {
    mutating func heapSort() {
        buildMaxHeap(&self)

        var i = count - 1

        while i > 0 {
            unsafe_swap(0, i)
            heapify(&self, i: 0, max: i)
            i -= 1
        }
    }

    func heapSorted() -> [Element] {
        var array = self
        array.heapSort()
        return array
    }

    func buildMaxHeap(_ array: inout [Element]) {
        var i = array.count / 2

        while i >= 0 {
            heapify(&array, i: i, max: array.count)
            i -= 1
        }
    }

    func heapify(_ array: inout [Element], i: Int, max: Int) {
        let left = 2 * i + 1
        let right = 2 * i + 2

        var largest = i

        if left < max, array[left] > array[largest] {
            largest = left
        }

        if right < max, array[right] > array[largest] {
            largest = right
        }

        if largest != i {
            array.unsafe_swap(i, largest)
            heapify(&array, i: largest, max: max)
        }
    }
}
