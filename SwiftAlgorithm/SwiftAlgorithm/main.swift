//
//  main.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

var data = "aaabbbcccdddf".data(using: .ascii)!

(data as NSData)/
(data.compressRLE() as NSData)/

//if let data = try? Data.init(contentsOf: URL(string: "http://che.org.il/wp-content/uploads/2016/12/pdf-sample.pdf")!, options: []) {
    print(data.count)
    print(data.compressRLE().count)
    print(data.compressRLE().compressRLE().count)
    print(data.compressRLE().compressRLE().compressRLE().count)
    print(data == data.compressRLE().decompressRLE())
//}

