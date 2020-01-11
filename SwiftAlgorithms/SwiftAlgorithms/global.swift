//
//  global.swift
//  SwiftAlgorithms
//
//  Created by 莫锹文 on 2019/12/27.
//  Copyright © 2019 莫锹文. All rights reserved.
//

extension Array {
    mutating func unsafe_swap(_ a: Array.Index, _ b: Array.Index) {
        (self[a], self[b]) = (self[b], self[a])
    }
}
