//
//  Hanoi.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/7/23.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

struct Hanoi {
    
    // 将n个圆盘从x柱移向y柱
    static func hanoi(n: Int, x: String, y: String, z: String) {
        if n != 0 {
            hanoi(n: n - 1, x: x, y: z, z: y) // 将n-1个圆盘从x柱移向z柱
            print("\(x) -> \(y)")             // 将1个（最大）圆盘从x柱移向y柱子
            hanoi(n: n - 1, x: z, y: y, z: x) // 将n-1个圆盘从z柱移向y柱
        }
    }
    
}
