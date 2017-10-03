//
//  Sample.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/10/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

struct Sample {
    private init() {}
    
    @inline(__always) private static func random(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min)) + 1)
    }
    
    // 将k个元素交换到数组的前k个位置
    static func select<T>(from a: [T], count k: Int) -> [T] {
        assert(a.count >= k)
        
        var a = a
        
        for i in 0..<k {
            let r = random(min: 0, max: a.count - 1)
            
            if r != i {
                a.swapAt(i, r)
            }
        }
        
        return Array(a[0..<k])
    }
    
    // 将数组的前k个元素取出组成结果数组，对剩下的元素随机进入结果数组
    static func reservoirSample<T>(from a: [T], count k: Int) -> [T] {
        precondition(a.count >= k)
        
        var result = Array(a[..<k])
        
        for i in k..<a.count {
            let r = random(min: 0, max: i)
            
            if r < k {
                result[r] = a[i]
            }
        }
        
        return result
    }
    
    // 以上两种算法有一个问题，取出的数组的顺序和其在原数组中的顺序不同
    
    // 生成一个属于 [0, 1) 的随机数r
    // 如果剩下可选的数量与r的乘积小于剩下需要的数量，则选中该元素
    static func orderedSelect<T>(from a: [T], count requested: Int) -> [T] {
        var examined = 0 // 已经选过的数量
        var selected = 0 // 已经选出的数量
        var b = [T]()

        while selected < requested {
            examined += 1

            let r = Double(arc4random()) / 0x100000000 // [0, 1)
//            let r = 0.001
//            let r = 0.999
//            let r = 0.5
            
            let leftToExamine = a.count - examined + 1 // 剩下可选的数量
            let leftToAdd = requested - selected // 剩下需要的数量

            if Double(leftToExamine) * r < Double(leftToAdd) {
                selected += 1
                b.append(a[examined - 1])
            }
        }

        return b
    }
}
