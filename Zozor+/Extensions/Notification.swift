//
//  Notification.swift
//  CountOnMe
//
//  Created by Levent Bostanci on 20/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let text = Notification.Name(rawValue: "text")
    static let total = Notification.Name(rawValue: "total")
    static let calculationAlert = Notification.Name(rawValue: "NewCalculationAlert")
    static let expressionAlert = Notification.Name(rawValue: "incorrectExpressionAlert")
    static let dividByZero = Notification.Name(rawValue: "DivideByZero")
}
