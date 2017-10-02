//
//  KthLargest.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/30.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

// 寻找数组中第K大的元素
struct KthLargest {
    private init() {}
    
    static func randomizedSelect<T: Comparable & CustomStringConvertible>(array: [T], order k: Int) -> T {
        var a = array
        
        // 任选数组中一个元素作为轴pivot，将所有大于pivot的元素移到pivot的后面，将所有小于pivot的元素移到pivot的前面
        func randomizedPartition<T: Comparable>(a: inout [T], _ low: Int, _ high: Int) -> Int {
            
            // 随机取数组中元素，将其换到数组末尾，不妨直接取数组末尾元素
            let pivot = a[high]
            
            var i = low  // 标记所有小于pivot元素的位置
            
            /*
             * 实际的操作是，遍历数组的index，
             * 若该位置的元素不大于pivot，则将其与标志位元素互换位置，并将标志位前移
             */
            for j in low..<high where a[j] <= pivot {
                (a[i], a[j]) = (a[j], a[i])
                i += 1
            }
            
            // 将pivot元素换到标志位上，则pivot前都是小于pivot的元素，后面都是大于pivot的元素
            (a[i], a[high]) = (a[high], a[i])
            return i
        }
        
        func randomizedSelect<T: Comparable>(a: inout [T], _ low: Int, _ high: Int, _ k: Int) -> T {
            if low < high {
                // 取做过一次交换操作的数组的pivot位置，即整个数组第p大的元素
                let p = randomizedPartition(a: &a, low, high)
                if k == p {
                    // 如果pivot的位置恰好为k，则其为数组第k大的元素
                    return a[p]
                } else if k < p {
                    // 如果pivot的位置在k之前，则对数组从头到pivot的元素做相同的操作
                    return randomizedSelect(a: &a, low, p - 1, k)
                } else {
                    // 如果pivot的位置在k之后，则对数组从pivot到尾的元素做相同的操作
                    return randomizedSelect(a: &a, p + 1, high, k)
                }
            } else {
                // 表示数组中只有一个元素
                return a[low]
            }
        }
        
        precondition(!array.isEmpty)
        return randomizedSelect(a: &a, 0, a.count - 1, k)
    }
}
