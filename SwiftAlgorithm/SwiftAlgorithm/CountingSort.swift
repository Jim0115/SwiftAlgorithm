//
//  CountingSort.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/11/4.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 计数排序是一种非比较排序 主要的使用场景是待排序的数组元素集中在一个固定的范围内
// 算法的时间复杂度为 O(n + k) k 表示数组内元素的范围
// 基于比较的排序算法时间复杂度下限为 O(n log n)
// 所以当 k > n log n，即元素的范围远大于元素的个数时，计数排序的复杂度要高于一般的比较排序
// 由于需要一个数组用于计数，空间复杂度为 O(k)
struct CountingSort {
    private init() {}
    
    static func sort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }
        
        let maxElement = array.max() ?? 0
        
        // 构造一个从长度为max的数组用于计数 ex: [1, 2, 3, 3, 2]
        var countArray = [Int](repeating: 0, count: maxElement + 1)
        
        // index [0, 1, 2, 3]
        // value [0, 1, 2, 2]
        // index 表示数值 value 表示对应数值出现的次数
        for element in array {
            countArray[element] += 1
        }
        
        // 处理计数数组 使其 value 表示当前数值在结果数组中的结束位置
        // [0, 1, 3, 5]
        for index in 1..<countArray.count {
            countArray[index] += countArray[index - 1]
        }
        
        // 使用计数数组构造结果数组
        
        // 具体的做法是 遍历原数组
        // 使用拿到的值作为 index， 获取计数数组中的 value
        // 由于 value 表示的是对应数值在结果数组中的结束位置
        // 可以将结果数组中对应位置放入对应的值，并将结束位置前移
        // 原数组遍历完成 结果数组全部位置被填满
        var sortedArray = [Int](repeating: 0, count: array.count)
        for element in array {
            countArray[element] -= 1
            sortedArray[countArray[element]] = element
        }
        return sortedArray
    }
}
