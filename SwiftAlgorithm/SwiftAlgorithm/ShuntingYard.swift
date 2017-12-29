//
//  ShuntingYard.swift
//  SwiftAlgorithm
//
//  Created by 王仕杰 on 2017/12/25.
//  Copyright © 2017年 王仕杰. All rights reserved.
//

enum OperatorAssocativity {
    case left, right
}

enum Operator: CustomStringConvertible {
    case add, substract, divide, multiply, percent, exponent
    
    var description: String {
        switch self {
        case .add:
            return "+"
        case .substract:
            return "-"
        case .divide:
            return "/"
        case .multiply:
            return "*"
        case .percent:
            return "%"
        case .exponent:
            return "^"
        }
    }
}

enum TokenType: CustomStringConvertible {
    case openBracket, closeBracket
    case Operator(OperatorToken)
    case operand(Double)
    
    var description: String {
        switch self {
        case .openBracket:
            return "("
        case .closeBracket:
            return ")"
        case .operand(let value):
            return value.description
        case .Operator(let token):
            return token.description
        }
    }
}

struct OperatorToken: CustomStringConvertible {
    let operatorType: Operator
    
    var percedence: Int {
        switch operatorType {
        case .add, .substract:
            return 0
        case .divide, .multiply, .percent:
            return 5
        case .exponent:
            return 10
        }
    }
    
    var associativity: OperatorAssocativity {
        switch operatorType {
        case .add, .substract:
            fallthrough
        case .divide, .multiply, .percent:
            return .left
        case .exponent:
            return .right
        }
    }
    
    var description: String {
        return operatorType.description
    }
}

extension OperatorToken: Comparable {
    static func <(lhs: OperatorToken, rhs: OperatorToken) -> Bool {
        return lhs.percedence < rhs.percedence
    }
    
    static func ==(lhs: OperatorToken, rhs: OperatorToken) -> Bool {
        return lhs.percedence == rhs.percedence
    }
}

struct Token: CustomStringConvertible {
    let tokenType: TokenType
    
    init(tokenType: TokenType) {
        self.tokenType = tokenType
    }
    
    init(operand: Double) {
        tokenType = .operand(operand)
    }
    
    init(operatorType: Operator) {
        tokenType = .Operator(.init(operatorType: operatorType))
    }
    
    var isOperBracket: Bool {
        if case .openBracket = tokenType {
            return true
        }
        return false
    }
    
    var isOperator: Bool {
        if case .Operator = tokenType {
            return true
        }
        return false
    }
    
    var operatorToken: OperatorToken? {
        if case .Operator(let token) = tokenType {
            return token
        }
        return nil
    }
    
    var description: String {
        return tokenType.description
    }
}

class InfixExpressionBuilder: CustomStringConvertible {
    private var expression = [Token]()
    
    func add(operator: Operator) -> InfixExpressionBuilder {
        expression.append(.init(operatorType: `operator`))
        return self
    }
    
    func add(operand: Double) -> InfixExpressionBuilder {
        expression.append(.init(operand: operand))
        return self
    }
    
    func addOpenBracket() -> InfixExpressionBuilder {
        expression.append(.init(tokenType: .openBracket))
        return self
    }
    
    func addCloseBracket() -> InfixExpressionBuilder {
        expression.append(.init(tokenType: .closeBracket))
        return self
    }
    
    func build() -> [Token] {
        return expression
    }
    
    var description: String {
        return expression.map { $0.description }.joined(separator: " ")
    }
}

func reversePolishNotation(expression: [Token]) -> String {
    var tokenStack = Stack<Token>()
    var result = [Token]()
    
    // 对于不同记号的处理方式：
    // 数字：直接加入结果队列
    // 左括号：入栈
    // 右括号：直到上一个左括号为止，依次出栈放入结果队列
    // 操作符：如果栈顶不是操作符，操作符入栈
    //        否则，记 o1 为当前操作符，o2 为栈顶操作符
    //        如果 (o1 左结合 && o1 优先级 <= o2 优先级) || （o1 右结合 && o1 优先级 < o2 优先级）
    //        o2 出栈加入结果队列，循环直到条件不满足
    //        最后将 o1 入栈
    for token in expression {
        switch token.tokenType {
        case .operand:
            result.append(token)
        case .openBracket:
            tokenStack.push(token)
        case .closeBracket:
            while !tokenStack.isEmpty, let tmpToken = tokenStack.pop(), !tmpToken.isOperBracket {
                result.append(tmpToken)
            }
        case .Operator(let operatorToken):
            for tmpToken in tokenStack.makeIterator() {
                guard tmpToken.isOperator else { break }
                
                if let tempOperatorToken = tmpToken.operatorToken {
                    if operatorToken.associativity == .left && operatorToken <= tempOperatorToken ||
                        operatorToken.associativity == .right && operatorToken < tempOperatorToken {
                        result.append(tokenStack.pop()!)
                    }
                } else {
                    break
                }
            }
            tokenStack.push(token)
        }
    }
    
    while let top = tokenStack.pop() {
        result.append(top)
    }
    
    return result.map { $0.description }.joined(separator: " ")
}

