//
//  Run-LengthEncoding.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/11/26.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

/*
 * 游程编码 无损压缩 本质是使用连续出现字节的次数代替原始数据
 * 适用于连续重复字节相对多的情况 例如pdf文件 tiff文件等
 * 在某些情况下可能导致压缩后的结果比原数据更大
 */


// 单个 byte 的范围为 0～255
// 编码时，count记录为出现次数+191。对于0～191的单个byte直接使用，192～255的byte使用 192byte的形式
// 解码时，0～191直接使用 192～255对应1～64个连续对应byte
extension Data {
    func compressRLE() -> Data {
        var data = Data()
        // 每 8bit（1 byte）作为最小元素
        withUnsafeBytes { (uPtr: UnsafePointer<UInt8>) in
            var ptr = uPtr
            let end = ptr + count
            
            while ptr < end {
                var count = 0
                var byte = ptr.pointee
                var next = byte
                
                // 计算连续出现元素的次数
                while next == byte && ptr < end && count < 64 {
                    ptr = ptr.advanced(by: 1)
                    next = ptr.pointee
                    count += 1
                }
                
                if count > 1 || byte >= 192 {
                    var size = 191 + UInt8(count)
                    data.append(&size, count: 1)
                    data.append(&byte, count: 1)
                } else {
                    data.append(&byte, count: 1)
                }
            }
        }
        
        return data
    }
    
    func decompressRLE() -> Data {
        var data = Data()
        
        withUnsafeBytes { (uPtr: UnsafePointer<UInt8>) in
            var ptr = uPtr
            let end = ptr + count
            
            while ptr < end {
                if ptr.pointee < 192 {
                    data.append(ptr, count: 1)
                    ptr = ptr.advanced(by: 1)
                } else {
                    var byte = ptr.advanced(by: 1).pointee
                    for _ in 0..<Int(ptr.pointee) - 191 {
                        data.append(&byte, count: 1)
                    }
                    ptr = ptr.advanced(by: 2)
                }
            }
        }
        
        return data
    }
    
}
