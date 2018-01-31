//
//  BitSet.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2018/1/31.
//  Copyright © 2018年 王仕杰. All rights reserved.
//

struct BitSet {
    private(set) var size: Int
    
    private let N = 64
    typealias Word = UInt64
    
    private(set) var words: [Word]
    
    init(size: Int) {
        precondition(size > 0)
        
        self.size = size
        
        let n = (size + N - 1) / N
        words = [Word](repeating: 0, count: n)
    }
    
    private func index(of i: Int) -> (Int, Word) {
        precondition(i >= 0 && i < size)
        
        let o = i / N // 对应的word位置
        let m = Word(i - o * N) // 获取word内的位置的mask
        return (o, 1 << m)
    }
    
    mutating func set(_ i: Int) { // 对应bit设为1
        let (j, m) = index(of: i)
        words[j] |= m
    }
    
    mutating func clean(_ i: Int) { // 对应bit设为0
        let (j, m) = index(of: i)
        words[j] &= ~m
    }
    
    func isSet(_ i: Int) -> Bool {
        let (j, m) = index(of: i)
        return (words[j] & m) != 0
    }
    
    subscript(i: Int) -> Bool {
        get {
            return isSet(i)
        }
        set {
            newValue ? set(i) : clean(i)
        }
    }
    
    mutating func cleanAll() {
        words = [Word](repeating: 0, count: words.count)
    }
}
