//
//  OrderedArray.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2018/2/2.
//  Copyright © 2018年 王仕杰. All rights reserved.
//

struct OrderedArray<T: Comparable> {
    fileprivate var array = [T]()
    
    init(array: [T]) {
        self.array = array.sorted()
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    subscript(index: Int) -> T {
        return array[index]
    }
    
    mutating func insert(_ e: T) {
//        func _insertPoint(_ e: T) -> Int {
//            for i in array {
//                if i >= e {
//                    return array.index(of: i)!
//                }
//            }
//            return array.count
//        }
        func _insertPoint(_ e: T) -> Int {
            var start = 0
            var end = array.count
            
            while start < end {
                let mid = start + (end - start) / 2
                if array[mid] == e {
                    return mid
                } else if array[mid] < e {
                    start = mid + 1
                } else {
                    end = mid
                }
            }
            return start
        }
        array.insert(e, at: _insertPoint(e))
    }
    
    mutating func remove(at index: Int) {
        array.remove(at: index)
    }
    
    mutating func removeAll() {
        array.removeAll()
    }
}

extension OrderedArray: CustomStringConvertible {
    var description: String {
        return array.description
    }
}
