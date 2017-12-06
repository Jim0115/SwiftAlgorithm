//
//  main.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

var data =
    """
The extra 0-bit at the end is there to make a full number of bytes. We were able to compress the original 34 bytes into merely 16 bytes, a space savings of over 50%!

To be able to decode these bits, we need to have the original frequency table. That table needs to be transmitted or saved along with the compressed data. Otherwise, the decoder does not know how to interpret the bits. Because of the overhead of this frequency table (about 1 kilobyte), it is not beneficial to use Huffman encoding on small inputs.
"""/.data(using: .ascii)!

"origin: "/
(data as NSData)/.length/
"RLE: "/
(data.compressRLE() as NSData)/.length/

let huffman = Huffman()
let newData = huffman.compress(data: data)

"Huffman encoded: "/
(newData as NSData)/.length/

let h = Huffman()
let oldData = h.decompress(data: newData, frequencyTable: huffman.frequencyTable)

"Huffman decoded: "/
(oldData as NSData)/.length/

"result: "/
String.init(data: oldData, encoding: .utf8)/
