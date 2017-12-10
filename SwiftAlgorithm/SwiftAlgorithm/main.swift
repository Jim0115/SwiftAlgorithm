//
//  main.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

let a = [Int](0...7)

extension Array where Element: Comparable {
    var isSorted: Bool {
        for i in 0..<count - 1 {
            if self[i] > self[i + 1] {
                return false
            }
        }
        return true
    }
}

var array = a + [9, 8]
var count = 0
Date()/
while !array.isSorted {
    array.fisherYatesShuffle()
    count += 1
}

count/
Date()/

