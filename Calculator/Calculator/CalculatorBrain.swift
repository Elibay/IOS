//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Elibay Nuptebek on 13.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var curentSum: Double? = 0
    private var globalSum: Double = 0
    private var pbo: PendingOperation?
    mutating func setOperation (_ operand: Double) {
        curentSum = operand
    }
    private enum Operation {
        case constant (Double)
        case binaryOperation ((Double, Double) -> Double)
        case unaryOperation ((Double) -> Double)
        case result
    }
    private var Operations: [String: Operation] = [
        "π": Operation.constant (Double.pi),
        
        "√": Operation.unaryOperation(sqrt),
        "±": Operation.unaryOperation({-$0}),
        
        "÷": Operation.binaryOperation(/),
        "×": Operation.binaryOperation(*),
        "-": Operation.binaryOperation(-),
        "+": Operation.binaryOperation(+),
        
        "=": Operation.result,
    ]
    private struct PendingOperation {
        var firstOperand: Double
        var function: (Double, Double) -> Double
        func perform (with secondOperand: Double) -> Double {
            return function (firstOperand, secondOperand)
        }
    }
    mutating func performOperation(_ symbol: String) {
        if let operation = Operations[symbol] {
            switch operation {
            case .constant(let value):
                curentSum = value
                globalSum = value
            case .unaryOperation(let function):
                if pbo != nil {
                    curentSum = pbo?.firstOperand
                    globalSum = curentSum!
                }
                if curentSum != nil {
                    curentSum = function(curentSum!)
                    globalSum = curentSum!
                }
            case .binaryOperation(let function):
                if curentSum != nil {
                    if pbo != nil {
                        curentSum = pbo!.perform (with: curentSum!)
                    }
                    pbo = PendingOperation (firstOperand: curentSum!, function: function)
                    globalSum = curentSum!
                    curentSum = nil
                }
                else {
                    print (globalSum)
                    pbo = PendingOperation(firstOperand: globalSum, function: function)
                }
            case .result:
                if curentSum != nil {
                    if pbo == nil {
                        globalSum = curentSum!
                        break
                    }
                    curentSum = pbo?.perform(with: curentSum!)
                    globalSum = curentSum!
                    pbo = nil
                }
            }
        }
    }
    var result: Double? {
        return globalSum
    }
}
