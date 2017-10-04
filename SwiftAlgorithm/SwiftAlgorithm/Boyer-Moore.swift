//
//  Boyer-Moore.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/9/19.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

extension String {
    
    func boyerMooreIndex(of pattern: String) -> Index? {
        
        guard !self.isEmpty else { return nil }
        
        // 缓存需要匹配字符串的长度
        let patternLength = pattern.characters.count
        guard patternLength > 0 else { return self.startIndex }
        guard patternLength <= characters.count else { return nil }
        
        // 进行匹配时，使用skipTable决定跳过的长度
        // 如果在pattern存在相同字符，则以小的为准，因为需要优先对其距离结尾更近的字符
        var skipTable = [Character : Int]()
        pattern.enumerated().forEach {
            skipTable[$1] = patternLength - $0 - 1
        }
        
        // pattern的最后一个字符位置
        let p = pattern.index(before: pattern.endIndex)
        // pattern的最后一个字符
        let lastChar = pattern[p]
        
        // 匹配开始位置，若pattern的长度为5，则从self的5位置开始
        // 所以pattern越长，本算法效率越高
        var i = index(startIndex, offsetBy: patternLength - 1)
        
        
        // 从两个字符串的末尾开始向前匹配，如果直到pattern的头部都相同，则返回self对应的index，即为pattern的index
        // 否则返回nil
        func backwards() -> Index? {
            var q = p
            var j = i
            while q > pattern.startIndex {
                j = index(before: j)
                q = index(before: q)
                if self[j] != pattern[q] { return nil }
            }
            return j
        }
        
        // 从匹配开始位置直到结束
        while i < endIndex {
            let c = self[i]
            
            // 判断待匹配位置对应字符是否与pattern的最后一个字符相同
            if c == lastChar {
                // 若是，则开始向前匹配过程
                // 如果发现匹配成功，返回index
                if let k = backwards() { return k }
                
                // 匹配不成功，将匹配开始位置向后移动一位
                // 移动一位是因为如果使用skipTable则会后移0位
                i = index(after: i)
            } else {
                // 待匹配位置对应字符与pattern的最后一个字符不同
                // 如果skipTable中存在待匹配位置对应字符，则后移对应的位置，对其lastChar与pattern中对应字符，否则后移整个pattern的长度
                // 如果直到endIndex都没有，则表示匹配失败
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
}
