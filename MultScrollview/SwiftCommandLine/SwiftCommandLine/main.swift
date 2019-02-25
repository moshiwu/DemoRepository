//
//  main.swift
//  SwiftCommandLine
//
//  Created by 莫锹文 on 2018/11/19.
//  Copyright © 2018 莫锹文. All rights reserved.
//

import Foundation

struct PackageA {
    struct A {
        var foo = ""
    }
}

struct PackageB {
    struct Bar {
    }
}

protocol P {
    var foo: PackageB.Bar { get }
}

extension PackageA.A: P {
    var foo: PackageB.Bar {
        return Bar()
    }
}
