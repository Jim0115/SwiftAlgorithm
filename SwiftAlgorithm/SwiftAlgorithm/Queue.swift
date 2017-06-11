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
 * 元素从队尾进入队列 从队首离开队列
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

/*
 * 上述队列有一个问题 每次dequeue操作的复杂度为O(n)
 * 原因在于 每次dequeue都需要将数组中所有元素向前移动
 * 如果不使用数组而是使用链表可以解决问题
 * 使用数组的解决方案如下
 */

public struct OptimizedQueue<T> {
    fileprivate var innerArray = [T?]()
    fileprivate var head = 0
    
    public var count: Int {
        return innerArray.count - head
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public mutating func enqueue(_ e: T) {
        innerArray.append(e)
    }
    
    public mutating func dequeue() -> T? {
        guard head < innerArray.count, let element = innerArray[head] else { return nil }
        
        innerArray[head] = nil
        head += 1
        
        let percentage = Double(head) / Double(innerArray.count)
        
        if innerArray.count > 50 && percentage > 0.25 {
            innerArray.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public var front: T? {
        return isEmpty ? nil : innerArray[head]
    }
}

extension OptimizedQueue: CustomStringConvertible {
    public var description: String {
        return innerArray[head..<innerArray.endIndex].map { $0! }.description
    }
}
