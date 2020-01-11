//
//  main.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

import Foundation

var array = [Int]()

for i in -100 ... 100 {
    array.append(Int.random(in: -100 ... 100))
//    array.append(i)
}
//
array.shuffle()
//
var origin = array.sorted()

print(array)

print(array.selectionSorted() == origin)

array.selectionSort()
print(array)
print(array == origin)


//var array = [-1, -2, -3, -4, -5]
//array.countingSort()
//print(array)
