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
        for (i, op) in operators.enumerated().reversed() where op == "x" || op == "/" {
            var operation: ((Float, Float) -> Float)?
            if op == "x" {
                operation = (*)
            } else if op == "/" && stringNumbers[i] != "0" {
                operation = (/)
            } else {
                showNotification(name: .dividByZero)
                clear()
            }
            guard let oper = operation else { return }
            guard let firstNumber = Float(stringNumbers[i-1]) else { return }
            guard let secondNumber = Float(stringNumbers[i]) else { return }
            let total = oper(firstNumber, secondNumber)
            let totalstr = String(format: "%.2f", total)
            stringNumbers[i-1] = String(totalstr)
            stringNumbers.remove(at: i)
            operators.remove(at: i)
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
