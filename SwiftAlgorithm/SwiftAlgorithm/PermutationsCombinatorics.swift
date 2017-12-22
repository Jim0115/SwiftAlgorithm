//
//  PermutationsCombinatorics.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/22.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

private extension Int {
    var factorial: Int {
        precondition(self > 0)
        return (1...self).reduce(1, *)
    }
}

struct Permutation {
    private init() { }
    
    static func permutations(_ n: Int, _ k: Int) -> Int {
        precondition(n > k)
        return ((n - k + 1)...n).reduce(1, *)
    }
    
    static func permute<T>(with array: [T], n: Int) {
        if n == 0 {
            print(array)
        } else {
            var array = array
            permute(with: array, n: n - 1)
            for i in 0..<n {
                array.swapAt(i, n)
                permute(with: array, n: n - 1)
                array.swapAt(i, n)
            }
        }
    }
}
