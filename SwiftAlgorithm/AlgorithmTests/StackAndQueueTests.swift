//
//  StackAndQueueTests.swift
//  AlgorithmTests
//
//  Created by 王仕杰 on 2017/9/26.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import XCTest

class StackAndQueueTests: XCTestCase {

    func testStack() {
        var s = Stack<Int>()
        XCTAssertTrue(s.isEmpty)
        XCTAssertNil(s.pop())
        s.push(10)
        XCTAssertFalse(s.isEmpty)
        XCTAssertEqual(s.pop(), 10)
        XCTAssertTrue(s.isEmpty)
        XCTAssertNil(s.pop())
        
        s.push(1)
        s.push(2)
        s.push(3)
        XCTAssertEqual(s.pop(), 3)
        XCTAssertEqual(s.pop(), 2)
        XCTAssertEqual(s.pop(), 1)
        XCTAssertTrue(s.isEmpty)
        XCTAssertNil(s.pop())
    }

    func testQueue() {
        var q = Queue<Int>()
        XCTAssertTrue(q.isEmpty)
        XCTAssertNil(q.dequeue())
        q.enqueue(10)
        XCTAssertFalse(q.isEmpty)
        XCTAssertEqual(q.dequeue(), 10)
        XCTAssertTrue(q.isEmpty)
        XCTAssertNil(q.dequeue())
        
        q.enqueue(1)
        q.enqueue(2)
        q.enqueue(3)
        XCTAssertEqual(q.dequeue(), 1)
        XCTAssertEqual(q.dequeue(), 2)
        XCTAssertEqual(q.dequeue(), 3)
        XCTAssertTrue(q.isEmpty)
        XCTAssertNil(q.dequeue())
    }
    
    func testOptimizedQueue() {
        var q = OptimizedQueue<Int>()
        XCTAssertTrue(q.isEmpty)
        XCTAssertNil(q.dequeue())
        q.enqueue(10)
        XCTAssertFalse(q.isEmpty)
        XCTAssertEqual(q.dequeue(), 10)
        XCTAssertTrue(q.isEmpty)
        XCTAssertNil(q.dequeue())
        
        q.enqueue(1)
        q.enqueue(2)
        q.enqueue(3)
        XCTAssertEqual(q.dequeue(), 1)
        XCTAssertEqual(q.dequeue(), 2)
        XCTAssertEqual(q.dequeue(), 3)
        XCTAssertTrue(q.isEmpty)
        XCTAssertNil(q.dequeue())
    }
}
