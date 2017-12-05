//
//  HuffmanCoding.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/5.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

public class BitWriter {
    public var data = Data()
    var outByte: UInt8 = 0
    var outCount = 0
    
    public func writeBit(bit: Bool) {
        if outCount == 8 {
            data.append(outByte)
            outCount = 0
        }
        outByte = (outByte << 1) | (bit ? 1 : 0)
        outCount += 1
    }
    
    public func flush() {
        if outCount > 0 {
            if outCount < 8 {
                let diff = UInt8(8 - outCount)
                outByte <<= diff
            }
            data.append(outByte)
        }
    }
}

public class BitReader {
    var index: Data.Index
    private var data: Data
    var inByte: UInt8 = 0
    var inCount = 0
    
    public init(data: Data) {
        self.data = data
        index = data.startIndex
    }
    
    public func readBit() -> Bool {
        if inCount == 8 {
            inByte = data[index]
            inCount = 0
            index = data.index(after: index)
        }
        let bit = inByte & 0b1000_0000  //0x80
        inByte <<= 1
        inCount += 1
        return bit == 0 ? false : true
    }
}
