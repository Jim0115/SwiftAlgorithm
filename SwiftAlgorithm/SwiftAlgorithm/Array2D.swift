//
//  Array2D.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2018/1/30.
//  Copyright © 2018年 王仕杰. All rights reserved.
//

public struct Array2D<T> {
    public let columns: Int
    public let rows: Int
    
    private var array: [T]
    
    public init(columns: Int, rows: Int, initialValue: T) {
        self.columns = columns
        self.rows = rows
        array = .init(repeating: initialValue, count: columns * rows)
    }
    
    public subscript(column: Int, row: Int) -> T {
        get {
            precondition(column < columns, "Column \(column) Index is out of range. Array<\(T.self)>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<\(T.self).self>(columns: \(columns), rows:\(rows))")
            return array[row * columns + column]
        }
        
        set {
            precondition(column < columns, "Column \(column) Index is out of range. Array<\(T.self)>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<\(T.self)>(columns: \(columns), rows:\(rows))")
            array[row * columns + column] = newValue
        }
    }
}
