//
//  main.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/6/3.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

import Foundation

let a = InfixExpressionBuilder().add(operand: 5).add(operator: .add).addOpenBracket().add(operand: 5).add(operator: .add).addOpenBracket().addOpenBracket().add(operand: 1)
.add(operator: .add).add(operand: 2).addCloseBracket().add(operator: .multiply).add(operand: 4).addCloseBracket().addCloseBracket().add(operator: .substract).add(operand: 3)/.build()
reversePolishNotation(expression: a)/
