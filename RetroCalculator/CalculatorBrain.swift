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
    
    private var operations: Dictionary<String,Operation> = [  // dictionary used so more operations can easily be added
        "+" : Operation.BinaryOperation({$0 + $1}),
        "X" : Operation.BinaryOperation({$0 * $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "/" : Operation.BinaryOperation({$0 / $1}),
        "=" : Operation.Equals,
        "C" : Operation.Constant(0.0)
        
    ]
    
    private enum Operation { // types of operations
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        case Constant(Double) // used for Pi
        //case UnaryOperation((Double) -> Double) // used for sqrt or other functions
    }
    
    func performOperation(symbol:String){ //handles calculation
        if let operation = operations[symbol] {
            switch operation {
                // case . Constant(let value): accumulator = value
            //case .UnaryOperation(let function) : accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperartion()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperartion()
            case .Constant(let constant):
                accumulator = constant
                pending = nil // reset any binary operation to nil
            }
        }
    }
    
    private func executePendingBinaryOperartion () { // executes binary operation
        if pending != nil {
            self.accumulator = pending!.binaryFunction(pending!.firstOperand,self.accumulator)
            pending = nil
        }
    }
    
    private var pending:PendingBinaryOperationInfo? // variable to indicate if there is a binary operation in progress
    
    private struct  PendingBinaryOperationInfo { // info for binary operation
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    var result:Double {
        get {
            return accumulator
        }
    }
    
}
