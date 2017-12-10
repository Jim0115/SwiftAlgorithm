//
//  HuffmanCoding.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/5.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 哈夫曼编码的本质上是统计每一个字节出现的次数
// 在编码时，出现频率高的字节对应较短的编码 达到使编码后数据长度变短的目的
import Foundation

// 按 bit 来读写 Data 中数据的便捷方法
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
        var count = 0 // 代表当前 index 对应的 byte 值出现的次数，即对应 byte 的权值
        var index: NodeIndex = -1 // 当前的 byte值
        var parent: NodeIndex = -1 // 当前节点的父节点
        var left: NodeIndex = -1
        var right: NodeIndex = -1 // 左右子节点
    }
    
    // 构建哈夫曼树是哈夫曼编码的核心部分 哈夫曼树即最优二叉树 这种树使得树的带权路径长度最短
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
    
    // 编码表 编码表可以使用哈夫曼树生成 也可以使用编码表恢复哈夫曼树
    var frequencyTable: [Freq] {
        var a = [Freq]()
        a.reserveCapacity(256)

        // 编码表即原始数据中每个byte出现的次数
        for i in 0..<256 where tree[i].count > 0 {
            a.append(Freq(byte: UInt8(i), count: tree[i].count))
        }
        return a
    }
    
    fileprivate func buildTree() {
        // 需要使用一个最小堆或优先队列用于构建哈夫曼树，其中包含了所有权值不为0的叶子节点
        var heap = Heap<Node>(array: tree.filter { $0.count > 0 }) { $0.count < $1.count } // priority queue or heap here
        
        while heap.count > 1 {
            // 每次取出权值最小的两个节点
            let node1 = heap.remove()!
            let node2 = heap.remove()!
            
            // 创建两个权值最小节点的父节点，使得父节点的权值等于两子节点之和
            var parent = Node()
            parent.count = node1.count + node2.count
            parent.left = node1.index
            parent.right = node2.index
            parent.index = tree.count
            tree.append(parent) // 将这个父节点加入树
            
            tree[node1.index].parent = parent.index
            tree[node2.index].parent = parent.index
            
            heap.insert(parent) // 父节点同样放入优先队列
        }
        
        // 每次操作从优先队列中取出两个最小节点，再加入一个新节点，队列中节点会不断减少
        // 当队列中只有一个节点时，这个节点即树的根节点
        let rootNode = heap.remove()!
        root = rootNode.index
    }
    
    // 哈夫曼编码
    public func compress(data: Data) -> Data {
        countByteFrequence(inData: data) // 统计数据中 byte 的权值
        buildTree() // 构建哈夫曼树

        let writer = BitWriter()

        // 对数据中的每个byte获取其压缩后的数据写入
        for v in data {
            let i = Int(v)
            traverseTree(writer: writer, nodeIndex: i, childIndex: -1)
        }
        
        writer.flush()
        return writer.data
    }
    
    // 知道节点index 求编码后数据
    private func traverseTree(writer: BitWriter, nodeIndex index: Int, childIndex child: Int) {
        // 首先从给定的节点开始，向上直到到达根节点，构建出从根节点到给定节点的路径
        if tree[index].parent != -1 {
            traverseTree(writer: writer, nodeIndex: tree[index].parent, childIndex: index)
        }
        
        // 按照路径，写入对应的bit 左1右0
        if (child != -1) {
            if child == tree[index].left {
                writer.writeBit(bit: true)
            } else if child == tree[index].right {
                writer.writeBit(bit: false)
            }
        }
    }
    
    // 使用编码表可以恢复所有叶子节点对应byte的出现次数 之后只要使用相同的方法即可构建出完整的哈夫曼树
    private func restoreTree(from frequencyTable: [Freq]) {
        for f in frequencyTable {
            let i = Int(f.byte)
            tree[i].count = f.count
            tree[i].index = i
        }
        buildTree()
    }
    
    // 哈夫曼解码
    func decompress(data: Data, frequencyTable: [Freq]) -> Data {
        // 解码时 需要用编码时产生的码表恢复哈夫曼树
        restoreTree(from: frequencyTable)
        
        let reader = BitReader(data: data)
        var result = Data()
        let byteCount = tree[root].count // 所有byte一共出现的次数
        
        for _ in 0..<byteCount {
            result.append(findLeafNode(reader: reader, nodeIndex: root))
        }
        
        assert(result.count == byteCount)
        return result
        
    }
    
    // 编码的逆过程 已知编码后数据 求原数据index
    private func findLeafNode(reader: BitReader, nodeIndex: Int) -> UInt8 {
        var h = nodeIndex // 从根节点开始
        while tree[h].right != -1 { // 直到叶子节点
            if reader.readBit() { // 同样是左1右0
                h = tree[h].left
            } else {
                h = tree[h].right
            }
        }
        return UInt8(h)
    }
}

