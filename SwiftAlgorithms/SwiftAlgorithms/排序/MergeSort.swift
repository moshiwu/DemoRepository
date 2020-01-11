//
//  MergeSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 归并排序
///
/// 时间复杂度：
/// 平均：O(nlogn)
/// 最好：O(nlogn)
/// 最坏：O(nlogn)
///

extension Array where Element: Comparable {
    mutating func mergeSort() {
        if count < 2 {
            return
        }

        let middle = count / 2
        var left = Array(self[0 ..< middle])
        var right = Array(self[middle ..< count])

        left.mergeSort()
        right.mergeSort()
        self = merge(array1: left, array2: right)
    }

    func mergeSorted() -> [Element] {
        var array = self
        array.mergeSort()
        return array
    }

    private func merge(array1: [Element], array2: [Element]) -> [Element] {
        var result = [Element]()

        var index1 = 0
        var index2 = 0

        while index1 < array1.count, index2 < array2.count {
            let element1 = array1[index1]
            let element2 = array2[index2]

            if element1 < element2 {
                result.append(element1)
                index1 += 1
            } else {
                result.append(element2)
                index2 += 1
            }
        }

        while index1 < array1.count {
            result.append(array1[index1])
            index1 += 1
        }

        while index2 < array2.count {
            result.append(array2[index2])
            index2 += 1
        }

        return result
    }
}
