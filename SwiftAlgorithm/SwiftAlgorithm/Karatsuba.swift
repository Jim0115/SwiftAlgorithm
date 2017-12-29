//
//  Karatsuba.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/29.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import func Foundation.pow

precedencegroup ExponentiativePrecedence {
    higherThan: MultiplicationPrecedence
    lowerThan: BitwiseShiftPrecedence
    associativity: left
}

infix operator ^^: ExponentiativePrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

struct Karatsuba {
    private init() { }
    
    static func mutiply(_ num1: Int, by num2: Int) -> Int {
        guard num1 > 9 && num2 > 9 else { return num1 * num2 }
        
        let num1Array = String(num1)
        let num2Array = String(num2)
        
        let n = max(num1Array.count, num2Array.count)
        let nBy2 = n / 2
        
        let a = num1 / 10^^nBy2
        let b = num1 % 10^^nBy2
        let c = num2 / 10^^nBy2
        let d = num2 % 10^^nBy2
        
        let ac = mutiply(a, by: c)
        let bd = mutiply(b, by: d)
        let adPlusbc = mutiply(a+b, by: c+d) - ac - bd
        
        let product = ac * 10^^(2 * nBy2) + adPlusbc * 10^^nBy2 + bd
        
        return product
    }
}
