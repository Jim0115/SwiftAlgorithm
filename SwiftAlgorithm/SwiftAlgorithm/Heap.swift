//
//  Heap.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/10/30.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

public struct Heap<T> {
    var elements = [T]()
    
    private var isOrderedBy: (T, T) -> Bool
    
    public init(sort: @escaping (T, T) -> Bool) {
        self.isOrderedBy = sort
    }
    
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.isOrderedBy = sort
        buildHeap(from: array)
    }
    
    private mutating func buildHeap(from array: [T]) {
        elements = array
        for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
            shiftDown(at: i, heapSize: elements.count)
        }
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    @inline(__always) func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    @inline(__always) func leftChildIndex(of index: Int) -> Int {
        return index * 2 + 1
    }
    
    @inline(__always) func rightChildIndex(of index: Int) -> Int {
        return index * 2 + 2
    }
    
    public var peek: T? {
        return elements.first
    }
    
    public mutating func insert(_ value: T) {
        elements.append(value)
        shiftUp(at: count - 1)
    }
    
    public mutating func insert<S: Sequence>(_ seq: S) where S.Element == T {
        for value in seq {
            insert(value)
        }
    }
    
    public mutating func replace(at index: Int, value: T) {
        guard index < count else { return }
        assert(!isOrderedBy(elements[index], value))
        elements[index] = value
        shiftUp(at: index)
    }
    
    @discardableResult public mutating func remove() -> T? {
        if count <= 1 {
            return elements.popLast()
        } else {
            let value = elements[0]
            elements[0] = elements.removeLast()
            shiftDown(at: 0, heapSize: elements.count)
            return value
        }
    }
    
    public mutating func remove(at index: Int) -> T? {
        guard index < count else { return nil }
        
        let size = elements.count - 1
        elements.swapAt(index, size)
        let value = elements.popLast()
        shiftUp(at: index)
        shiftDown(at: index, heapSize: size)
        
        return value
    }
    
    mutating func shiftUp(at index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = self.parentIndex(of: childIndex)
        
        while childIndex > 0 && isOrderedBy(child, elements[parentIndex]) {
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(of: childIndex)
        }
        
        elements[childIndex] = child
    }
    
    mutating func shiftDown(at index: Int, heapSize: Int) {
        var parentIndex = index
        
        while true {
            let leftChildIndex = self.leftChildIndex(of: parentIndex)
            let rightChildIndex = leftChildIndex + 1
            
            var first = parentIndex
            if leftChildIndex < heapSize && !isOrderedBy(elements[first], elements[leftChildIndex]) {
                first = leftChildIndex
            }
            
            if rightChildIndex < heapSize && !isOrderedBy(elements[first], elements[rightChildIndex]) {
                first = rightChildIndex
            }
            
            if first == parentIndex { return }
            
            elements.swapAt(parentIndex, first)
            parentIndex = first
        }
    }
}
