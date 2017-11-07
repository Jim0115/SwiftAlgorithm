//
//  BubbleSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/11/7.
//  Copyright © 2017年 王仕杰. All rights reserved.
//


struct BubbleSort {
    private init() {}
    
    static func sort<T: Comparable>(_ array: inout [T], isOrderedBy: (T, T) -> Bool = { $0 < $1 } ) {
        for i in 0..<array.count {
            for j in 0..<array.count - 1 {
                if isOrderedBy(array[i], array[j]) {
                    array.swapAt(i, j)
                }
            }
        }
    }
}
