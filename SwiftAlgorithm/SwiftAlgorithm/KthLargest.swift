//
//  KthLargest.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/30.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

struct KthLargest {
    private init() {}
    
    static func randomizedSelect<T: Comparable & CustomStringConvertible>(array: [T], order k: Int) -> T {
        var a = array
        
        func ramdomizedPartition<T: Comparable>(a: inout [T], _ low: Int, _ high: Int) -> Int {
            let pivot = a[high]
            var i = low
            
            for j in low..<high where a[j] <= pivot {
                (a[i], a[j]) = (a[j], a[i])
                i += 1
                a/
            }
            (a[i], a[high]) = (a[high], a[i])
            a/
            return i
        }
        
        func randomizedSelect<T: Comparable>(a: inout [T], _ low: Int, _ high: Int, _ k: Int) -> T {
            if low < high {
                let p = ramdomizedPartition(a: &a, low, high)
                if k == p {
                    return a[p]
                } else if k > p {
                    return randomizedSelect(a: &a, low, p - 1, k)
                } else {
                    return randomizedSelect(a: &a, p + 1, high, k)
                }
            } else {
                return a[low]
            }
        }
        
        precondition(!array.isEmpty)
        return randomizedSelect(a: &a, 0, a.count - 1, k)
    }
}
