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
        sortDispatcher(sortFunction: InsertionSort.sort)
        sortDispatcher(sortFunction: MergeSort.sort)
        sortDispatcher(sortFunction: SelectionSort.sort)
        sortDispatcher(sortFunction: ShellSort.sort)
    }
    
    func sortDispatcher(sortFunction: ([Int], @escaping (Int, Int) -> Bool) -> [Int]) {
        XCTAssertEqual(sortFunction([Int](), >), [Int]())
        XCTAssertEqual(sortFunction([Int](), <), [Int]())
        XCTAssertEqual(sortFunction([1], >), [1])
        XCTAssertEqual(sortFunction([1], <), [1])
        XCTAssertEqual(sortFunction([1, 2], <), [1, 2])
        XCTAssertEqual(sortFunction([1, 2], >), [2, 1])
        XCTAssertEqual(sortFunction([1, 1, 2], <), [1, 1, 2])
        XCTAssertEqual(sortFunction([1, 1, 2], >), [2, 1, 1])
        XCTAssertEqual(sortFunction([2, 1, 3], <), [1, 2, 3])
        XCTAssertEqual(sortFunction([2, 1, 3], >), [3, 2, 1])
        XCTAssertEqual(sortFunction(Array(1...100), <), Array(1...100))
        XCTAssertEqual(sortFunction(Array(1...100), >), Array(1...100).reversed())
        
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
