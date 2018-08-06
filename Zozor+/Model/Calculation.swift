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
    var total: Double = 0
    var isExpressionCorrect: Bool {
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
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                showNotification(name: .expressionAlert)
                return false
            }
        }
        return true
    }
    
    func showNotification(name: Notification.Name) {
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
    
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    func updateDisplay() {
        for (i, stringNumber) in stringNumbers.enumerated() {
            if i > 0 {
                text += operators[i]
            }
            text += stringNumber
        }
        showNotification(name: .text)
    }
    
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        calculationPriority()
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else {
                    total -= number
                }
            }
        }
        showNotification(name: .total)
    }
    
    private func calculationPriority() {
        for (i, op) in operators.enumerated().reversed() where op == "x" || op == "/" {
            var operation: ((Double, Double) -> Double)?
            if op == "x" {
                operation = (*)
            } else if op == "/" && stringNumbers[i] != "0" {
                operation = (/)
            } else {
                showNotification(name: .dividByZero)
                clear()
            }
            guard let oper = operation else { return }
            let total = oper(Double(stringNumbers[i-1])!, (Double(stringNumbers[i])!))
            stringNumbers[i-1] = String(total)
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
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        total = 0
    }
    
}
