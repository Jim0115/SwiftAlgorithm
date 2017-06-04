//
//  Queue.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/4.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

/* 
 * 队列 queue 与栈相对，是一个先进先出 first-in first-out FIFO 的集合类型
 * 元素从队尾进入队列 从队首离开对列
 */

public struct Queue<T> {
    fileprivate var innerArray = [T]()
    
    public var count: Int {
        return innerArray.count
    }
    
    public var isEmpty: Bool {
        return innerArray.isEmpty
    }
    
    public mutating func enqueue(_ e: T) {
        innerArray.append(e)
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : innerArray.removeFirst()
    }
    
    public var front: T? {
        return innerArray.first
    }
}
