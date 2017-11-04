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
    
    // buildHeap 方法有两种实现方式
    // 第一种方法 对数组的每个元素调用一次 insert 方法，每次为 O(log n) 整体为 O(n log n)
    // 第二种 从数组 1/2 位置开始，对之前的元素依次调用 shift down 方法 复杂度为 O(n)
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
    
    // 删除堆顶操作
    // 当堆中节点多于一个时，将堆顶和堆底互换
    // 删除新的堆底元素，然后做一次 shift down 操作
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
    
    // 删除指定位置元素
    // 将指定元素交换到堆底并移除
    // 做一次 shift up 和一次 shift down 操作
    public mutating func remove(at index: Int) -> T? {
        guard index < count else { return nil }
        
        let size = elements.count - 1
        elements.swapAt(index, size)
        let value = elements.popLast()
        shiftUp(at: index)
        shiftDown(at: index, heapSize: size)
        
        return value
    }
    
    // 对于一个节点的 shift up 操作判断其与父节点是否符合堆的规则
    // 若不满足规则，交换两节点，继续判断新节点与其父节点
    // 直到找到根节点或满足规则条件的节点
    // 此时整个堆的所有节点即满足规则
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
    
    // 类似于 shift up 操作，shift down 操作会判断一个节点与其子节点之间是否符合规则
    // 交换不满足规则的两节点并重复此操作
    // 直到找到所有符合规则的节点或叶子节点
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
