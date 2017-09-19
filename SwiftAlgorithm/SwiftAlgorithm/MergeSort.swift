//
//  MergeSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/18.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

struct MergeSort {
    static func sort<T: Comparable>(_ array: [T], isOrderedBy order: (T, T) -> Bool) -> [T] {
        guard array.count > 1 else { return array } // 只有一个元素的数组不需要处理
        
        // 分割数组
        let middleIndex = array.count / 2
        let leftArray = sort(Array(array[..<middleIndex]), isOrderedBy: order)
        let rightArray = sort(Array(array[middleIndex..<array.count]), isOrderedBy: order)
        
        return merge(left: leftArray, right: rightArray, isOrderedBy: order)
    }
    
    /// 归并操作
    ///
    /// - Parameters:
    ///   - left: 待合并有序数组
    ///   - right: 待合并有序数组
    /// - Returns: 合并后数组
    private static func merge<T: Comparable>(left: [T], right: [T], isOrderedBy: (T, T) -> Bool) -> [T] {
        var leftIndex = 0
        var rightIndex = 0
        var orderedArray = [T]()
        
        // 比较两个数组对应位置的元素，将较大／小的放入结果数组，直到某个数组为空
        while leftIndex < left.count && rightIndex < right.count {
            if isOrderedBy(left[leftIndex], right[rightIndex]) {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
            } else {
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        // 完成前一步操作后将剩余元素添加到结果数组
        (leftIndex..<left.count).forEach {
            orderedArray.append(left[$0])
        }
        
        (rightIndex..<right.count).forEach {
            orderedArray.append(right[$0])
        }
        
        return orderedArray
    }
    
    private init() {}
}
