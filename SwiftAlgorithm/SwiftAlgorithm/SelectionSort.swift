//
//  SelectionSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/10/22.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 总体思想是，从一个数组中拿出最小的元素，追加到另一个数组的末尾
// 或者是选出一个数组无需部分的最小元素，将其交换到有序部分
// 整体的复杂度为 O(n^2)

struct SelectionSort {
    private init() {}
    
    static func sort<T: Comparable>(_ array: [T], isOrderedBy: (T, T) -> Bool = { $0 < $1 } ) -> [T] {
        guard array.count > 1 else { return array }
        var array = array
        
        for i in 0 ..< array.count {
            var lowest = i
            for y in i + 1 ..< array.count where isOrderedBy(array[y], array[lowest]) {
                lowest = y
            }
            
            array.swapAt(lowest, i)
        }
        
        return array
    }
}
