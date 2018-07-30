//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Levent Bostanci on 26/07/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    
    var calculationTest: Calculation!
    
    override func setUp() {
        super.setUp()
        calculationTest = Calculation()
    }

    
    func testIsExpressionCorrect_WhenStringNumberContainNothing_ThenExpressionReturnFalse(){
        let isExpressionCorrect = calculationTest.isExpressionCorrect
        XCTAssertFalse(isExpressionCorrect)
    }
    
    func testIsExpressionCorrect_WhenStringNumberContainSomthing_ThenExpressionReturnTrue(){
        let _ = calculationTest.addNewNumber(1)
        let isExpressionCorrect = calculationTest.isExpressionCorrect
        XCTAssertEqual(isExpressionCorrect, true)
    }
    
    func testAddNewNumber_WhenUsersTapsOnIt_ThenNumberIsAdded() {
        let tappedNumber = 5
        calculationTest.addNewNumber(tappedNumber)
        XCTAssertEqual(calculationTest.stringNumbers.last, "5")
    }
    
    func testIsExpressionCorrect_WhenUserTapBadExpression_ThenExpressionReturnFalse() {
        calculationTest.addNewNumber(1)
        calculationTest.operators = ["+"]
        calculationTest.stringNumbers = [""]
        calculationTest.calculateTotal()
        XCTAssertEqual(calculationTest.isExpressionCorrect, false)
    }
    
    func testCanAddOperator_WhenStringNumberContainNothing_ThenExpressionReturnFalse() {
        calculationTest.stringNumbers = [""]
        XCTAssertEqual(calculationTest.canAddOperator, false)
    }
    
    func testCanAddOperator_WhenStringNumberContainSomething_ThenExpressionReturnTrue() {
        calculationTest.stringNumbers = ["1"]
        XCTAssertEqual(calculationTest.canAddOperator, true)
    }
    
    func testClear_WhenTotalIsComputed_ThenEveryInputIsClearedOut() {
        calculationTest.stringNumbers = ["1","2"]
        calculationTest.operators = ["+", "-"]
        calculationTest.total = -1
        calculationTest.clear()
        XCTAssertEqual(calculationTest.stringNumbers.count, 1)
        XCTAssertEqual(calculationTest.operators.count, 1)
        XCTAssertEqual(calculationTest.stringNumbers.last, "")
        XCTAssertEqual(calculationTest.operators.last, "+")
        XCTAssertEqual(calculationTest.total, 0)
    }
    
    func testCalculateTotal_WhenUserTapEqual_ThenExpressionReturnTrue() {
        calculationTest.stringNumbers = ["5", "5", "1"]
        calculationTest.operators = ["+", "+", "-"]
        calculationTest.total = 9
        XCTAssertEqual(calculationTest.total, 9)
    }
    
    func testCalculateTotal_WhenUserDividByZero_ThenExpressionReseted() {
        calculationTest.stringNumbers = ["2", "0"]
        calculationTest.operators = ["+", "/"]
        calculationTest.total = 0
        XCTAssertEqual(calculationTest.total, 0)
    }
    
    func testCalculateTotal_WhenUserTapBadExpression_ThenExpressionReseted() {
        calculationTest.stringNumbers = [""]
        calculationTest.operators = ["+"]
        XCTAssertEqual(calculationTest.total, 0)
    }
    
    func testGivenACorrectListOfNumbersAndOperatorsWhenUserTapsEqualsThenAResultIsCalculated() {
        calculationTest.stringNumbers = ["2","5","10", "2", "0"]
        calculationTest.operators = ["+", "x", "+", "/", "-"]
        calculationTest.calculateTotal()
        calculationTest.total = 15
        XCTAssertEqual(calculationTest.total, 15)
    }
    
    func testGivenAUserHasLastAddedAnOperatorWhenUserTapsEqualsThenExpressionIsIncorrect() {
        calculationTest.stringNumbers = ["22","23",""]
        calculationTest.operators = ["+", "-", "-"]
        calculationTest.calculateTotal()
        XCTAssertEqual(calculationTest.isExpressionCorrect, false)
    }

    func testGivenAListOfNumbersAndOperatorsWhenTheUserTapsANumberOrAnOperatorThenBothListsAreConcatenatedToText() {
        calculationTest.stringNumbers = ["22","23","13"]
        calculationTest.operators = ["+", "-", "-"]
        calculationTest.updateDisplay()
        XCTAssertEqual(calculationTest.text, "22-23-13")
    }
    
}
