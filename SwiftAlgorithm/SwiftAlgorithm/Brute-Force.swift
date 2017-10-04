//
//  Brute-Force.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/10/4.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

extension String {
    func bruteForceIndex(of pattern: String) -> String.Index? {
        for i in characters.indices {
            var j = i
            var found = true
            
            for p in pattern.characters.indices {
                if j == characters.endIndex || self[j] != pattern[p] {
                    found = false
                    break
                } else {
                    j = index(after: j)
                }
            }
            
            if found {
                return i
            }
        }
        
        return nil
    }
}
