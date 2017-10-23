//
//  SortTests.swift
//  AlgorithmTests
//
//  Created by 王仕杰 on 2017/9/22.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import XCTest

class SortTests: XCTestCase {

    func testSort() {
        XCTAssertEqual(InsertionSort.sort([Int](), isOrderedBy: >), [Int]())
        XCTAssertEqual(InsertionSort.sort([Int](), isOrderedBy: <), [Int]())
        XCTAssertEqual(InsertionSort.sort([1], isOrderedBy: >), [1])
        XCTAssertEqual(InsertionSort.sort([1], isOrderedBy: <), [1])
        XCTAssertEqual(InsertionSort.sort([1, 2], isOrderedBy: <), [1, 2])
        XCTAssertEqual(InsertionSort.sort([1, 2], isOrderedBy: >), [2, 1])
        XCTAssertEqual(InsertionSort.sort([1, 1, 2], isOrderedBy: <), [1, 1, 2])
        XCTAssertEqual(InsertionSort.sort([1, 1, 2], isOrderedBy: >), [2, 1, 1])
        XCTAssertEqual(InsertionSort.sort([2, 1, 3], isOrderedBy: <), [1, 2, 3])
        XCTAssertEqual(InsertionSort.sort([2, 1, 3], isOrderedBy: >), [3, 2, 1])
        XCTAssertEqual(InsertionSort.sort(Array(1...100), isOrderedBy: <), Array(1...100))
        XCTAssertEqual(InsertionSort.sort(Array(1...100), isOrderedBy: >), Array(1...100).reversed())
        
        XCTAssertEqual(MergeSort.sort([Int](), isOrderedBy: >), [Int]())
        XCTAssertEqual(MergeSort.sort([Int](), isOrderedBy: <), [Int]())
        XCTAssertEqual(MergeSort.sort([1], isOrderedBy: >), [1])
        XCTAssertEqual(MergeSort.sort([1], isOrderedBy: <), [1])
        XCTAssertEqual(MergeSort.sort([1, 2], isOrderedBy: <), [1, 2])
        XCTAssertEqual(MergeSort.sort([1, 2], isOrderedBy: >), [2, 1])
        XCTAssertEqual(MergeSort.sort([1, 1, 2], isOrderedBy: <), [1, 1, 2])
        XCTAssertEqual(MergeSort.sort([1, 1, 2], isOrderedBy: >), [2, 1, 1])
        XCTAssertEqual(MergeSort.sort([2, 1, 3], isOrderedBy: <), [1, 2, 3])
        XCTAssertEqual(MergeSort.sort([2, 1, 3], isOrderedBy: >), [3, 2, 1])
        XCTAssertEqual(MergeSort.sort(Array(1...10000), isOrderedBy: <), Array(1...10000))
        XCTAssertEqual(MergeSort.sort(Array(1...10000), isOrderedBy: >), Array(1...10000).reversed())
        
        XCTAssertEqual(SelectionSort.sort([Int](), isOrderedBy: >), [Int]())
        XCTAssertEqual(SelectionSort.sort([Int](), isOrderedBy: <), [Int]())
        XCTAssertEqual(SelectionSort.sort([1], isOrderedBy: >), [1])
        XCTAssertEqual(SelectionSort.sort([1], isOrderedBy: <), [1])
        XCTAssertEqual(SelectionSort.sort([1, 2], isOrderedBy: <), [1, 2])
        XCTAssertEqual(SelectionSort.sort([1, 2], isOrderedBy: >), [2, 1])
        XCTAssertEqual(SelectionSort.sort([1, 1, 2], isOrderedBy: <), [1, 1, 2])
        XCTAssertEqual(SelectionSort.sort([1, 1, 2], isOrderedBy: >), [2, 1, 1])
        XCTAssertEqual(SelectionSort.sort([2, 1, 3], isOrderedBy: <), [1, 2, 3])
        XCTAssertEqual(SelectionSort.sort([2, 1, 3], isOrderedBy: >), [3, 2, 1])
        XCTAssertEqual(SelectionSort.sort(Array(1...100), isOrderedBy: <), Array(1...100))
        XCTAssertEqual(SelectionSort.sort(Array(1...100), isOrderedBy: >), Array(1...100).reversed())
        
        XCTAssertEqual(ShellSort.sort([Int](), isOrderedBy: >), [Int]())
        XCTAssertEqual(ShellSort.sort([Int](), isOrderedBy: <), [Int]())
        XCTAssertEqual(ShellSort.sort([1], isOrderedBy: >), [1])
        XCTAssertEqual(ShellSort.sort([1], isOrderedBy: <), [1])
        XCTAssertEqual(ShellSort.sort([1, 2], isOrderedBy: <), [1, 2])
        XCTAssertEqual(ShellSort.sort([1, 2], isOrderedBy: >), [2, 1])
        XCTAssertEqual(ShellSort.sort([1, 1, 2], isOrderedBy: <), [1, 1, 2])
        XCTAssertEqual(ShellSort.sort([1, 1, 2], isOrderedBy: >), [2, 1, 1])
        XCTAssertEqual(ShellSort.sort([2, 1, 3], isOrderedBy: <), [1, 2, 3])
        XCTAssertEqual(ShellSort.sort([2, 1, 3], isOrderedBy: >), [3, 2, 1])
        XCTAssertEqual(ShellSort.sort(Array(1...100), isOrderedBy: <), Array(1...100))
        XCTAssertEqual(ShellSort.sort(Array(1...100), isOrderedBy: >), Array(1...100).reversed())
    }

    func testInsertionPerformance() {
        // This is an example of a performance test case.
        self.measure {
            let _ = InsertionSort.sort(Array(0...1000), isOrderedBy: >)
        }
    }
    
    func testInsertionPerformance2() {
        self.measure {
            let _ = InsertionSort.sort(Array(0...1000), isOrderedBy: <)
        }
    }
    
    func testMergePerformance() {
        self.measure {
            let _ = MergeSort.sort(Array(0...1000), isOrderedBy: >)
        }
    }
    
    func testMergePerformance2() {
        self.measure {
            let _ = InsertionSort.sort(Array(0...1000), isOrderedBy: <)
        }
    }
    
    func testMergePerformance3() {
        self.measure {
            let _ = MergeSort.sort(Array(0...10000), isOrderedBy: >)
        }
    }
    
    func testMergePerformance4() {
        self.measure {
            let _ = InsertionSort.sort(Array(0...10000), isOrderedBy: <)
        }
    }

}
