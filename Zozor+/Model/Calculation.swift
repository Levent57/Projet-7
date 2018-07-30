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
    var total = 0
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
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        showNotification(name: .text)
    }
    
//    func calculateTotal() {
//        if !isExpressionCorrect {
//            return
//        }
//        for (i, stringNumber) in stringNumbers.enumerated() {
//            if let number = Int(stringNumber) {
//                if operators[i] == "+" {
//                    total += number
//                } else if operators[i] == "-" {
//                    total -= number
//                } else if operators[i] == "x" {
//                    total *= number
//                } else if operators[i] == "/" && number != 0 {
//                    total /= number
//                } else {
//                    showNotification(name: .dividByZero)
//                    clear()
//                }
//            }
//        }
//        showNotification(name: .total)
//        clear()
//    }
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        prioritizeCalculation()
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else {
                    total -= number
                }
            }
        }
        showNotification(name: .total)
    }
    
    private func prioritizeCalculation() {
        for (index, op) in operators.enumerated().reversed() where op == "x" || op == "/" {
            var operation: ((Int, Int) -> Int)?
            if op == "x" {
                operation = (*)
            } else if op == "/" && stringNumbers[index] != "0" {
                operation = (/)
            } else {
                showNotification(name: .dividByZero)
                clear()
            }
            guard let oper = operation else { return }
            let total = oper(Int(stringNumbers[index-1])!, Int(stringNumbers[index])!)
            stringNumbers[index-1] = String(total)
            stringNumbers.remove(at: index)
            operators.remove(at: index)
        }
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        total = 0
    }
}
