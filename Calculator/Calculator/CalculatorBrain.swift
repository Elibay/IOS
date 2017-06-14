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
    private var pbo: PendingOperation?
    mutating func setOperation (_ operand: Double) {
        curentSum = operand
    }
    private enum Operation {
        case constant (Double)
        case binaryOperation ((Double, Double) -> Double)
        case unaryOperation ((Double) -> Double)
        case result
        case clear
    }
    private var Operations: [String: Operation] = [
        "π": Operation.constant (Double.pi),
        "√": Operation.unaryOperation(sqrt),
        "±": Operation.unaryOperation({-$0}),
        "÷": Operation.binaryOperation(/),
        "×": Operation.binaryOperation(*),
        "−": Operation.binaryOperation(-),
        "+": Operation.binaryOperation(+),
        "=": Operation.result,
        "AC": Operation.clear
    ]
    private struct PendingOperation {
        var firstOperand: Double
        var function: (Double, Double) -> Double
        func perform (with secondOperand: Double) -> Double {
            return function (firstOperand, secondOperand)
        }
    }
    mutating func performOperation (_ symbol: String)
    {
        if let operation = Operations[symbol] {
            switch operation {
            case .constant (let value):
                    curentSum = value
            case .clear:
                curentSum = 0
                pbo = nil
            case .unaryOperation (let function):
                if curentSum != nil {
                    curentSum = function (curentSum!)
                }
            case .binaryOperation (let function):
                pbo?.function = function
                if curentSum != nil {
                    pbo = PendingOperation(firstOperand: pbo == nil ? curentSum! : pbo!.perform(with: curentSum!),
                                                 function: function)
                    curentSum = nil
                }
            case .result:
                if curentSum != nil {
                    curentSum = pbo?.perform(with: curentSum!)
                    pbo = nil
                }
            }
        }
    }
    var result: Double? {
        return curentSum
    }
}
