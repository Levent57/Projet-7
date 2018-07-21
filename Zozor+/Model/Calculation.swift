//
//  Calculation.swift
//  CountOnMe
//
//  Created by Levent Bostanci on 20/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation
import UIKit

class Calculation {
    
    var text = ""
    var stringNumbers: [String] = [String]()
    var operators: [String] = ["+"]
    var total = 0
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    postNotification(name: .calculationAlert)
                } else {
                    postNotification(name: .expressionAlert)
                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                postNotification(name: .expressionAlert)
                return false
            }
        }
        return true
    }
    
    func postNotification(name: Notification.Name) {
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
    
    func addNewNumber (_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }
    
    func updateDisplay() {
        for (i, stringNumber) in stringNumbers.enumerated() {
            //AddOperator
            if i > 0 {
                text += operators[i]
            }
            //ADD Number
            text += stringNumber
        }
        postNotification(name: .total)
    }
    
    func calculateTotal(){
        if !isExpressionCorrect {
            return
        }
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        postNotification(name: .total)
        clear()
    }
    
    func clear() {
        stringNumbers = [String]()
        operators = ["+"]
        total = 0
    }
    
}
