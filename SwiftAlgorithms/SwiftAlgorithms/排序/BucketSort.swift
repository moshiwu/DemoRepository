//
//  BucketSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/30.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 桶排序
/// 必须知道元素中的最大值和最小值
///
/// 时间复杂度：
/// 平均：O(n+k)
/// 最好：O(n)
/// 最坏：O(n²)
///

extension Array where Element == Int {
    mutating func bucketSort() {
        if count <= 1 {
            return
        }

        var min: Int = 0
        var max: Int = 0

        for value in self {
            min = min < value ? min : value
            max = max > value ? max : value
        }

        bucketSortHelper(&self, minValue: min, maxValue: max)
    }

    func bucketSorted() -> [Element] {
        var array = self
        array.bucketSort()
        return array
    }

    private func bucketSortHelper(_ array: inout [Int], minValue: Int, maxValue: Int) {
        let bucketSize = 5
        let bucketCount = ((maxValue - minValue) / bucketSize) + 1

        var buckets: [[Int]] = .init(repeating: [], count: bucketCount)

        for i in 0 ..< array.count {
            let value = array[i]
            let index = (value - minValue) / bucketSize
            buckets[index].append(value)
        }

        var result = [Int]()

        for i in 0 ..< bucketCount {
            let bucket = buckets[i].sorted()
            for value in bucket {
                result.append(value)
            }
        }

        array = result
    }
}
