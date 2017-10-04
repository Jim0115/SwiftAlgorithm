//
//  StringSearchTests.swift
//  AlgorithmTests
//
//  Created by 王仕杰 on 2017/10/4.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import XCTest

class StringSearchTests: XCTestCase {

    func testBruteForce() {
        XCTAssertNil("".bruteForceIndex(of: ""))
        XCTAssertNil("".bruteForceIndex(of: "hello"))
        
        XCTAssertEqual("hello world".bruteForceIndex(of: ""), "hello world".startIndex)
        XCTAssertEqual("hello world".bruteForceIndex(of: "he"), "hello world".startIndex)
        XCTAssertEqual("hello world".bruteForceIndex(of: "hello world"), "hello world".startIndex)
        
        XCTAssertEqual("hello world".bruteForceIndex(of: " "), "hello world".index("hello world".startIndex, offsetBy: 5))
        XCTAssertEqual("hello world".bruteForceIndex(of: "rld"), "hello world".index("hello world".startIndex, offsetBy: 8))
        
        XCTAssertNil("hello world".bruteForceIndex(of: "ow"))
        XCTAssertNil("hello world".bruteForceIndex(of: "foo hello world bar"))
    }
    
    func testBoyerMoore() {
        XCTAssertNil("".boyerMooreIndex(of: ""))
        XCTAssertNil("".boyerMooreIndex(of: "hello"))
        
        XCTAssertEqual("hello world".boyerMooreIndex(of: ""), "hello world".startIndex)
        XCTAssertEqual("hello world".boyerMooreIndex(of: "he"), "hello world".startIndex)
        XCTAssertEqual("hello world".boyerMooreIndex(of: "hello world"), "hello world".startIndex)
        
        XCTAssertEqual("hello world".boyerMooreIndex(of: " "), "hello world".index("hello world".startIndex, offsetBy: 5))
        XCTAssertEqual("hello world".boyerMooreIndex(of: "rld"), "hello world".index("hello world".startIndex, offsetBy: 8))
        
        XCTAssertNil("hello world".boyerMooreIndex(of: "ow"))
        XCTAssertNil("hello world".boyerMooreIndex(of: "foo hello world bar"))
    }
}
