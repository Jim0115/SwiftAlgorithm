//
//  ShellSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/10/22.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 希尔排序比一般的插入排序复杂度低的原因：
//    1. 排序本质上是减小数组逆序数，希尔排序的一次交换减小的逆序数要比插入排序多
//    2. 插入排序对于大致有序的数组排序效率高，因此希尔排序最后gap为1的时候效率很高
struct ShellSort {
    private init() {}
    
    static func sort<T: Comparable>(_ array: [T], isOrderedBy: (T, T) -> Bool = { $0 < $1 } ) -> [T] {
        var array = array
        var subarrayCount = array.count / 2
        
        while subarrayCount > 0 {
            func insertionSorted(_ array: inout [T], start: Int, gap: Int, isOrderedBy: (T, T) -> Bool) {
                for i in stride(from: start + gap, to: array.count, by: gap) {
                    let currentValue = array[i]
                    var pos = i
                    while pos >= gap && isOrderedBy(currentValue, array[pos - gap]) {
                        array.swapAt(pos, pos - gap)
                        pos -= gap
                    }
                    array[pos] = currentValue
                }
            }
            
            for pos in 0..<subarrayCount {
                insertionSorted(&array, start: pos, gap: subarrayCount, isOrderedBy: isOrderedBy)
            }
            
            subarrayCount /= 2
        }
        
        return array
    }
}
