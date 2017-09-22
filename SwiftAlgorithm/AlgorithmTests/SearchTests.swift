//
//  SearchTests.swift
//  AlgorithmTests
//
//  Created by 王仕杰 on 2017/9/22.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import XCTest

class SearchTests: XCTestCase {
    func testSearch() {
        XCTAssertNil(LinearSearch.search([Int](), 10))
        XCTAssertEqual(LinearSearch.search([1], 1), 0)
        XCTAssertNil(LinearSearch.search([1], 0))
        XCTAssertEqual(LinearSearch.search([1, 2, 3], 2), 1)
        XCTAssertEqual(LinearSearch.search(Array(0...100), 50), 50)
        XCTAssertNil(LinearSearch.search(Array(0...100), 101))
        
        XCTAssertNil(BinarySearch.search([Int](), 10))
        XCTAssertEqual(BinarySearch.search([1], 1), 0)
        XCTAssertNil(BinarySearch.search([1], 0))
        XCTAssertEqual(BinarySearch.search([1, 2, 3], 2), 1)
        XCTAssertEqual(BinarySearch.search(Array(0...100), 50), 50)
        XCTAssertNil(BinarySearch.search(Array(0...100), 101))
    }
}
