//
//  LongestCommonSubsequence.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/10/18.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

// 最长公共子序列问题

struct LongestCommonSubsequence {
    private init() {}
    
    static func search(_ s1: String, with s2: String) -> String {
        // 整体的思路是使用动态规划+回溯
        
        // 返回对应长度两字符串之间的公共子序列长度 matrix[2][3] 表示 s1[0...1]和s2[0...2]的公共子序列长度
        // matrix[s1.count][s2.count]即表示两字符串的最大公共子序列长度
        func lcsLength(s1: String, s2: String) -> [[Int]] {
            var matrix = [[Int]](repeating: [Int](repeating: 0, count: s2.count + 1), count: s1.count + 1)
            
            for (i, c1) in s1.enumerated() {
                for (j, c2) in s2.enumerated() {
                    if c1 == c2 {
                        // 当找到两个相同的字符时，子序列长度 +1
                        // 例如 i = j = 0 时 c1 == c2， 表示两数组首字符相同
                        // 此时字符串 s1[0...0]和s2[0...0]的公共子序列长度为1 即 matrix[1][1] = 1
                        matrix[i + 1][j + 1] = matrix[i][j] + 1
                    } else {
                        // 如果相应位置的字符不相等，则利用之前的计算结果
                        // 例如 i = 3, j = 4 时， c1 != c2
                        // 此时 s1[0...2] 和 s2[0...3] 的公共子序列长度为之前计算出的
                        // (s1[0...2] 和 s2[0...2]) 与 (s1[0...1] 和 s2[0...3]) 之间公共子序列的最大值
                        matrix[i + 1][j + 1] = max(matrix[i + 1][j], matrix[i][j + 1])
                    }
                }
            }
            return matrix
        }
        
        // 回溯算法 根据之前计算出的对应位置公共子序列长度确定所需字符的位置，最终确定公共子序列
        func backtrack(_ matrix: [[Int]]) -> String {
            var i = s1.count // s1上的对应位置
            var j = s2.count // s2上的对应位置
            
            var result = String()
            
            // 对于某一特定的i, j 如果存在 matrix[i][j - 1] == matrix[i][j] 或 matrix[i - 1][j] == matrix[i][j]
            // 表示当前位置的长度继承自其之前的结果，因此该位置上的字符不是导致matrix的值增大的直接原因
            // 对该位置上的i或j做 -1 操作
            // 直到找到一对 i, j 使得 (matrix[i][j - 1] < matrix[i][j] && matrix[i - 1][j] < matrix[i][j])
            // 此时对应位置的字符就是公共子序列所需的元素
            // 记录该字符，将 i, j 同时 -1。 重复此步骤寻找所有公共子序列元素，直到找到某一字符串的头部结束
            while i >= 1 && j >= 1 {
                if matrix[i][j - 1] == matrix[i][j] {
                    j -= 1
                } else if matrix[i - 1][j] == matrix[i][j] {
                    i -= 1
                } else {
                    i -= 1
                    j -= 1
                    let index = s1.index(s1.startIndex, offsetBy: i)
                    result.append(s1[index])
                }
            }
            
            // 由于是从字符串的尾部开始查找 将所有查找到的字符逆序而成的字符串即为需要的最大公共子序列
            return String(result.reversed())
        }
        
        return backtrack(lcsLength(s1: s1, s2: s2))
    }
}
