//
//  Stack.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

/*
 * 栈 stack 是一个后进先出（last-in first-out, LIFO）的集合
 * 通常只支持对栈顶元素进行操作
 */

public struct Stack<T> {
    fileprivate var innerArray = [T]()
    
    public var count: Int {
        return innerArray.count
    }
    
    public var isEmpty: Bool {
        return innerArray.isEmpty
    }
    
    public mutating func push(_ e: T) {
        innerArray.append(e)
    }
    
    public mutating func pop() -> T? {
        return innerArray.popLast()
    }
    
    public var top: T? {
        return innerArray.last
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        innerArray = elements
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        if isEmpty {
            return "The stack is Empty!"
        } else {
            return innerArray.description + " <-- Top"
        }
    }
}
