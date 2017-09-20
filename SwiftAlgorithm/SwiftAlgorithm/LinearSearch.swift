//
//  LinearSearch.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/20.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// O(n)
struct LinearSearch {
    private init() {}
    
    static func search<T: Equatable>(_ array: [T], _ object: T) -> Int? {
        for (index, obj) in array.enumerated() where obj == object {
            return index
        }
        return nil
    }
}
