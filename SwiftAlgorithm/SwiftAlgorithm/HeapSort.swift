//
//  HeapSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/11/4.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 堆排序是一种利用堆的特性 -- 堆的最大/最小元素总在堆顶 的一种特殊的选择排序
// 由于堆的每次调整操作复杂度为 O(log n) 所以堆排序的整体复杂度为 O(n log n)

// 初始状态：[ 25, 13, 20, 8, 7, 17, 2, 5, 4 ]
// 将对应元素交换到数组尾部：[ 4, 13, 20, 8, 7, 17, 2, 5, | 25 ]
// shiftDown 操作后：[20, 13, 17, 8, 7, 4, 2, 5 | 25]
// 重复操作：[17, 13, 5, 8, 7, 4, 2 | 20, 25]
// 直到所有元素有序
fileprivate extension Heap {
    mutating func sort() -> [T] {
        for i in stride(from: (elements.count - 1), through: 1, by: -1) {
            elements.swapAt(0, i)
            shiftDown(at: 0, heapSize: i)
        }
        return elements
    }
}

struct HeapSort {
    private init() {}
    
    static func sort<T: Comparable>(_ array: [T], isOrderedBy order: @escaping (T, T) -> Bool = { $0 < $1 }) -> [T] {
        let newOrder: (T, T) -> Bool = { order($1, $0) }
        var h = Heap<T>(array: array, sort: newOrder)
        return h.sort()
    }
}
