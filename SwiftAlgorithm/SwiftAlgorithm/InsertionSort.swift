//
//  InsertionSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/11.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

struct InsertionSort {
    static func sort<T>(_ array: [T], isOrderedBy: (T, T) -> Bool) -> [T] {
        guard array.count > 1 else { return array }
        
        var a = array
        for x in 1..<a.count {
            var y = x
            let tmp = a[y]
            while y > 0 && isOrderedBy(tmp, a[y - 1]) {
                a[y] = a[y - 1]
                y -= 1
            }
            a[y] = tmp
        }
        return a
    }
}
