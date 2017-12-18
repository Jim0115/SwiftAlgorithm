//
//  main.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

do {
    try MinimumCoinChange(coinSet: [1, 2, 5, 10, 11]).changeDynamic(128)/.count/
    try MinimumCoinChange(coinSet: [1, 2, 5, 10, 11]).changeGreedy(128)/.count/
} catch {
    error/
}

