//
//  CountOccurrences.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/20.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 查找数组中某元素的出现次数，如果使用朴素的线性查找，复杂度为O(n)
// 对于一个有序的数组，可以使用二分查找的思想，分别找出待查找对象的上下限，即可求得对象个数
struct CountOccurrences {
    private init() { }
    
    static func count<T: Comparable>(obj: T, inArray array: [T]) -> Int {
        
        // 找到第一个待查找元素
        func leftBoundary() -> Int {
            var low = 0
            var high = array.count
            while low < high {
                let mid = low + (high - low) / 2
                if array[mid] < obj {
                    // 理解为用后一半
                    low = mid + 1
                } else {
                    // 前一半
                    high = mid
                }
            }
            return low
        }
        
        // 找到最后一个待查找元素
        func rightBoundary() -> Int {
            var low = 0
            var high = array.count
            while low < high {
                let mid = low + (high - low) / 2
                if array[mid] > obj {
                    // 前一半
                    high = mid
                } else {
                    // 后一半
                    low = mid + 1
                }
            }
            return high
        }
        
        return rightBoundary() - leftBoundary()
    }
}
