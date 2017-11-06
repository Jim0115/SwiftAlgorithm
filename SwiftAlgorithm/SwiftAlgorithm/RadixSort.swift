//
//  RadixSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/11/6.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 基数排序实际上就是不断的分发和合并的过程
// 每次分发合并后的数组会在其对应的位数上有序，且不会影响前一位的有序性
// 当整个数组的最高位操作完成时即整个数组有序
struct RadixSort {
    private init() {}
    
    static func sort(_ array: inout [Int]) {
        let radix = 10 // 以10作为基数
        var done = false
        var index: Int
        var digit = 1 // 当前所在的位数
        
        while !done {
            done = true
            
            // 创建基数个桶用于装基数相同的元素
            var buckets = [[Int]]()
            for _ in 1...radix {
                buckets.append([])
            }
            
            for number in array {
                // index 表示当前需要处理的位数所在的桶
                index = (number / digit) % radix
                buckets[index].append(number)
                
                // 一旦存在index 即表示需要处理的数组中仍有未处理完成的元素 需要升高位数继续处理
                if done && index > 0 {
                    done = false
                }
            }
            
            // 将每个桶中的数据展开到原数组中            
            array = Array(buckets.joined())
            
            // 位数 *= 基数 用于处理新的位数
            digit *= radix
        }
    }
}
