//
//  SlowSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/11/7.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

struct SlowSort {
    private init() {}
    
    private static func innerSort<T>(_ a: inout [T], isOrderedBy: (T, T) -> Bool, _ i: Int, _ j: Int) {
        guard i < j else { return }
        
        let m = (i + j) / 2
        
        innerSort(&a, isOrderedBy: isOrderedBy, i, m) // 对前一半进行排序
        innerSort(&a, isOrderedBy: isOrderedBy, m + 1, j) // 对后一半进行排序
        // 数组前一半和后一半都是有序的 所以前一半和后一半两个最大元素的index分别为j和m
        // 将其中较大的放到数组尾部
        if isOrderedBy(a[j], a[m]) {
            a.swapAt(j, m)
        }
        // 对剩余的元素继续排序
        innerSort(&a, isOrderedBy: isOrderedBy, i, j - 1)
    }
    
    static func sort<T: Comparable>(_ array: inout [T], isOrderedBy: (T, T) -> Bool = { $0 < $1 } )  {
        innerSort(&array, isOrderedBy: isOrderedBy, 0, array.count - 1)
    }
}
