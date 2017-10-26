//
//  QuickSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/10/23.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

struct QuickSort {
    private init() {}
    
    private func sampleSort<T: Comparable>(_ array: [T]) -> [T] {
        guard array.count > 1 else { return array }
        
        let pivot = array[array.count / 2]
        
        return sampleSort(array.filter { $0 < pivot}) + array.filter { $0 == pivot} + sampleSort(array.filter { $0 > pivot})
    }
    
    
    
    static func sortLomuto<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
        
        // 此方法在寻找数组中第k大元素时也使用过
        // 可能存在的一个问题是，如果数组中存在多个与pivot相同的值，不能保证这些值最后都集中在pivot的附近
        func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
            let pivot = a[high]
            
            var i = low
            for j in low ..< high {
                if a[j] <= pivot {
                    a.swapAt(i, j)
                    i += 1
                }
            }
            
            a.swapAt(i, high)

            return i
        }
        
        if low < high {
            let p = partitionLomuto(&array, low: low, high: high)
            sortLomuto(&array, low: low, high: p - 1)
            sortLomuto(&array, low: p + 1, high: high)
        }
    }
    
    static func sortHoare<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
        func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
            let pivot = a[low]
            var i = low - 1
            var j = high + 1
            
            while true {
                repeat { i += 1 } while a[i] < pivot
                repeat { j -= 1 } while a[j] > pivot
                
                if i < j {
                    a.swapAt(i, j)
                } else {
                    return j
                }
            }
        }
        
        if low < high {
            let p = partitionHoare(&array, low: low, high: high)
            sortHoare(&array, low: low, high: p)
            sortHoare(&array, low: p + 1, high: high)
        }
    }
}
