//
//  Calculation.swift
//  CountOnMe
//
//  Created by Levent Bostanci on 20/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculation {
    
    var text = ""
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var total: Float = 0 //for décimal numbers
    var isExpressionCorrect: Bool { //check if there is empty or have only one member in number stack.
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    showNotification(name: .calculationAlert)
                } else {
                    showNotification(name: .expressionAlert)
                }
                return false
            }
        }
        return true
    }
    
    //that check if there is one number in number stack, if yes you can add operator
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                showNotification(name: .expressionAlert)
                return false
            }
        }
        return true
    }
    
    //allows communication with the viewController
    func showNotification(name: Notification.Name) {
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
    
    //add new number, tapped by the user
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    //Interactively update text to display keystrokes and results
    func updateDisplay() {
        for (i, stringNumber) in stringNumbers.enumerated() {
            if i > 0 {
                text += operators[i]
            }
            text += stringNumber
        }
        showNotification(name: .text)
    }
    
    //Perform the operation between the 2 numbers
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        calculationPriority()
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Float(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else {
                    total -= number
                }
            }
        }
        showNotification(name: .total)
    }
    
    //manage calculation priorities and displaying the result
    private func calculationPriority() {
        let priorityOperators = ["x", "/"]
        var result : Float = 0
        var i = 0
        while i < stringNumbers.count - 1 {
            if var firstNumber = Float(stringNumbers[i]){
                while priorityOperators.contains(operators[i + 1]){
                    if let secondNumber = Float(stringNumbers[i + 1]){
                        if operators[i + 1] == "x"{
                            result = firstNumber * secondNumber
                        } else if operators[i + 1] == "/" && secondNumber != 0{
                            result = firstNumber / secondNumber
                        } else {
                            showNotification(name: .dividByZero)
                            clear()
                            return
                        }
                        stringNumbers[i] = String(format: "%.2f", result)
                        firstNumber = result
                        stringNumbers.remove(at: i + 1)
                        operators.remove(at: i + 1)
                        if i == stringNumbers.count - 1{
                            return
                        }
                    }
                }
                i += 1
            }
        }
    }
    
    func plusAction(){
        if canAddOperator {
            operators.append("+")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func minusAction(){
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func mulitiplyAction(){
        if canAddOperator {
            operators.append("x")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func dividAction(){
        if canAddOperator {
            operators.append("/")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func equalAction(){
        calculateTotal()
    }
    
    //clear
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        total = 0
    }
    
}
