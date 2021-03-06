//
//  MinimumCoinChange.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/18.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

enum MinimumCoinChangeError: Error {
    case noRestPossableForGivenValue
}

struct MinimumCoinChange {
    private let sortedCoinSet: [Int]
    
    init(coinSet: [Int]) {
        sortedCoinSet = coinSet.sorted(by: >)
    }
}

// 贪心算法: 每次都选择局部最优解 以期达到全局最优解
// 每次都从大面额的硬币开始
extension MinimumCoinChange {
    func changeGreedy(_ value: Int) throws -> [Int] {
        guard value > 0 else { return [] }
        
        var change = [Int]()
        var value = value
        
        for coin in sortedCoinSet {
            while value - coin >= 0 {
                change.append(coin)
                value -= coin
            }
            
            if value == 0 { return change }
        }
        
        throw MinimumCoinChangeError.noRestPossableForGivenValue
    }
}

// 动态规划 Dynamic Programming
// 找零问题是使用动态规划解决的经典问题
// 动态规划的基本思想是：计算并储存最小问题的解，将这些最小问题的解合并得到整体问题的解
extension MinimumCoinChange {
    func changeDynamic(_ value: Int) throws -> [Int] {
        guard value > 0 else { return [] }
        
        // 记录计算过问题的解
        var cache = [Int : [Int]]()
        
        func _changeDynamic(_ value: Int) -> [Int] {
            guard value > 0 else { return [] }
            
            if let cached = cache[value] { return cached }
            
            // 记录当前value的可能解，不一定是最优解
            var tempChangeArray = [[Int]]()
            
            for coin in sortedCoinSet {
                if value >= coin {
                    var tempChange = [coin]
                    tempChange += _changeDynamic(value - coin)
                    
                    if tempChange.sum == value {
                        // 找到一个 value 的可能解
                        tempChangeArray.append(tempChange)
                    }
                }
            }
            
            if let minimumChange = tempChangeArray.min(by: { $0.count < $1.count }) {
                // 从所有可能解中找出最优解并记录
                cache[value] = minimumChange
                return minimumChange
            }
            
            return []
        }
        
        let change = _changeDynamic(value)
        
        if change.sum != value { throw MinimumCoinChangeError.noRestPossableForGivenValue }
        
        return change
    }
}

private extension Array where Element == Int {
    var sum: Int {
        return reduce(0, +)
    }
}
