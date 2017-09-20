//
//  BinarySearch.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/20.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// O(log n)
// 二分查找要求待查找的数组是有序的，通常的排序算法的复杂度为O(nlogn)
// 所以二分查找适用于需要统一数组进行多次查找的场合
struct BinarySearch {
    private init() { }
    
    static func search<T: Comparable>(_ array: [T], _ object: T) -> Int? {
        
        func binary<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
            guard range.upperBound > range.lowerBound else { return nil }
            
            let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
            
            if a[midIndex] > key {
                // 中间值大于查找值 取前一半
                return binary(a, key: key, range: range.lowerBound ..< midIndex)
            } else if a[midIndex] == key {
                // 找到
                return midIndex
            } else {
                // 中间值小于查找值 取后一半
                return binary(a, key: key, range: midIndex + 1 ..< range.upperBound)
            }
        }
        
        return binary(array, key: object, range: 0..<array.count)
    }
    
    
}
