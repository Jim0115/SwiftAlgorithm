//
//  GreatestCommonDivisor.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/21.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

struct GCD {
    private init() { }
    
    static func gcd(a: Int, b: Int) -> Int {
        let r = a % b
        if r == 0 {
            return b
        }
        return gcd(a: b, b: r)
    }
    
    static func iterativeGCD(a: Int, b: Int) -> Int {
        var a = a
        var b = b
        var r = 1
        
        while r != 0 {
            r = a % b
            a = b
            b = r
        }
        
        return a
    }
}

struct LCM {
    private init() { }
    
    static func lcm(a: Int, b: Int) -> Int {
        return a / GCD.gcd(a: a, b: b) * b
    }
}
