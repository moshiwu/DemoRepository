//
//  RadixSort.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/30.
//  Copyright © 2019 莫锹文. All rights reserved.
//

/// 基数排序
/// 元素必须是正整数
///
/// 时间复杂度：
/// 平均：O(n * k)
/// 最好：O(n * k)
/// 最坏：O(n * k)
///

extension Array where Element == UInt {
    mutating func radixSort() {
        if let max = self.max() {
            let maxDigit = String(max).count
            radixSortHelper(&self, maxDigit: maxDigit)
        }
    }

    func radixSorted() -> [Element] {
        var array = self
        array.radixSort()
        return array
    }

    private func radixSortHelper(_ array: inout [UInt], maxDigit: Int) {
        var counter: [Int: [UInt]] = [:]
        var mod: UInt = 10
        var dev: UInt = 1

        for _ in 0 ..< maxDigit {
            for i in 0 ..< array.count {
                let value = array[i]
                let bucket = Int((value % mod) / dev)

                if counter[bucket] == nil {
                    counter[bucket] = []
                }

                counter[bucket]!.append(value)
            }

            var pos = 0

            for i in 0 ..< counter.count {
                if var temp = counter[i] {
                    while !temp.isEmpty {
                        array[pos] = temp.removeFirst()
                        pos += 1
                    }
                }
            }

            counter.removeAll()

            dev *= 10
            mod *= 10
        }
    }
}
