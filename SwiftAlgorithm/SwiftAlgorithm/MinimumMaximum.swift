//
//  MinimumMaximum.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/20.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

struct MinimumMaximum {
    private init() { }
    
    static func minimum<T: Comparable>(_ array: [T]) -> T? {
        guard var minimum = array.first else { return nil }
        array.forEach { minimum = (minimum < $0 ? minimum : $0) }
        return minimum
    }
    
    static func maximum<T: Comparable>(_ array: [T]) -> T? {
        guard let maximum = array.first else { return nil }
        return array.reduce(maximum) {
            return $0 > $1 ? $0 : $1
        }
    }
    
    static func minimumMaximum<T: Comparable>(_ array: [T]) -> (minimum: T, maximum: T)? {
        guard var minimum = array.first else { return nil }
        var maximum = minimum
        
        let start = array.count % 2
        for i in stride(from: start, to: array.count, by: 2) {
            var pair = (array[i], array[i + 1])
            if pair.0 > pair.1 { (pair.0, pair.1) = (pair.1, pair.0)}
            if pair.0 < minimum { minimum = pair.0 }
            if pair.1 > maximum { maximum = pair.1 }
        }
        
        return (minimum, maximum)
    }
}
