//
//  Tools.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

postfix operator /

@discardableResult postfix func /<T> (element: T) -> T {
    print("\(element) --- Type: \(T.self)")
    return element
}
