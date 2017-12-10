//
//  Shuffle.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/10.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

fileprivate func random(under max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max)))
}

extension Array {
    public mutating func shuffle() {
        var temp = [Element]()
        
        while !isEmpty {
            let i = random(under: count)
            temp.append(remove(at: i))
        }
        
        self = temp
    }
    
    public func shuffled() -> [Element] {
        var tmp = self
        tmp.shuffle()
        return tmp
    }
    
    public mutating func fisherYatesShuffle() {
        for i in (1...count - 1).reversed() {
            let j = random(under: i)
            swapAt(i, j)
        }
    }
}
