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
    var inCount = 8
    
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

class Huffman {
    typealias NodeIndex = Int
    
    struct Node {
        var count = 0 // 代表当前 index 对应的 byte 值出现的次数
        var index: NodeIndex = -1 // 当前的 byte值
        var parent: NodeIndex = -1 // 当前节点的父节点
        var left: NodeIndex = -1
        var right: NodeIndex = -1 // 左右子节点
    }
    
    var tree = [Node](repeating: Node(), count: 256)
    
    var root: NodeIndex = -1
    
    fileprivate func countByteFrequence(inData data: Data) {
        for value in data {
            let index = Int(value)
            tree[index].count += 1
            tree[index].index = index
        }
    }
    
    struct Freq {
        var byte: UInt8 = 0
        var count = 0
    }
    
    var frequencyTable: [Freq] {
        var a = [Freq]()
        a.reserveCapacity(256)

        for i in 0..<256 where tree[i].count > 0 {
            a.append(Freq(byte: UInt8(i), count: tree[i].count))
        }
        return a
    }
    
    fileprivate func buildTree() {
        var heap = Heap<Node>(array: tree.filter { $0.count > 0 }) { $0.count < $1.count } // priority queue or heap here
        
        while heap.count > 1 {
            let node1 = heap.remove()!
            let node2 = heap.remove()!
            
            var parent = Node()
            parent.count = node1.count + node2.count
            parent.left = node1.index
            parent.right = node2.index
            parent.index = tree.count
            tree.append(parent)
            
            tree[node1.index].parent = parent.index
            tree[node2.index].parent = parent.index
            
            heap.insert(parent)
        }
        
        let rootNode = heap.remove()!
        root = rootNode.index
    }
    
    public func compress(data: Data) -> Data {
        countByteFrequence(inData: data)
        buildTree()

        let writer = BitWriter()

        for v in data {
            let i = Int(v)
            traverseTree(writer: writer, nodeIndex: i, childIndex: -1)
        }
        
        writer.flush()
        return writer.data
    }
    
    private func traverseTree(writer: BitWriter, nodeIndex index: Int, childIndex child: Int) {
        if tree[index].parent != -1 {
            traverseTree(writer: writer, nodeIndex: tree[index].parent, childIndex: index)
        }
        
        if (child != -1) {
            if child == tree[index].left {
                writer.writeBit(bit: true)
            } else if child == tree[index].right {
                writer.writeBit(bit: false)
            }
        }
    }
    
    private func restoreTree(from frequencyTable: [Freq]) {
        for f in frequencyTable {
            let i = Int(f.byte)
            tree[i].count = f.count
            tree[i].index = i
        }
        buildTree()
    }
    
    func decompress(data: Data, frequencyTable: [Freq]) -> Data {
        restoreTree(from: frequencyTable)
        
        let reader = BitReader(data: data)
        var result = Data()
        let byteCount = tree[root].count
        
        var i = 0
        while i < byteCount {
            result.append(findLeafNode(reader: reader, nodeIndex: root))
            i += 1
        }
        return result
        
    }
    
    private func findLeafNode(reader: BitReader, nodeIndex: Int) -> UInt8 {
        var h = nodeIndex
        while tree[h].right != -1 {
            if reader.readBit() {
                h = tree[h].left
            } else {
                h = tree[h].right
            }
        }
        return UInt8(h)
    }
}

