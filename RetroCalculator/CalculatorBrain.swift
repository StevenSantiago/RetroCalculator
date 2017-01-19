//
//  CalculatorBrain.swift
//  RetroCalculator
//
//  Created by Steven Santiago on 1/19/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand (operand : Double){
    accumulator = operand
    }
    
    var operations: Dictionary<String,Operation> = [
        "+" : Operation.BinaryOperation({$0 + $1}),
        "X" : Operation.BinaryOperation({$0 * $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "/" : Operation.BinaryOperation({$0 / $1}),
        "=" : Operation.Equals
    
    ]
    
    enum Operation {
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        //case Constant(Double) // used for Pi
        //case UnaryOperation((Double) -> Double) // used for sqrt or other functions
    }
    
    func performOperation(symbol:String){
        if let operation = operations[symbol] {
        switch operation {
       // case . Constant(let value): accumulator = value
        //case .UnaryOperation(let function) : accumulator = function(accumulator)
        case .BinaryOperation(let function):
            executePendingBinaryOperartion()
            pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
        case .Equals:
            executePendingBinaryOperartion()
        }
        }
    }
    
    private func executePendingBinaryOperartion () {
        if pending != nil {
            self.accumulator = pending!.binaryFunction(pending!.firstOperand,self.accumulator)
            pending = nil
        }
    }
    
    private var pending:PendingBinaryOperationInfo?
    
    struct  PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    var result:Double {
        get {
            return accumulator
        }
    }
    
}
