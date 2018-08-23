//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let calculation = Calculation()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    //manages the various error messages, operations and display
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextDisplay), name: .text, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayNewCalculation), name: .calculationAlert, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayExpressionAlert), name: .expressionAlert, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayTotal), name: .total, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dividByZero), name: .dividByZero , object: nil)
    }
    
    deinit { //when the controller is not active
        NotificationCenter.default.removeObserver(self)
    }

    //manage the numbers typed by the user
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calculation.addNewNumber((i))
            }
        }
    }

    //manage operators typed by the user
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "+":
            calculation.plusAction()
        case "-":
            calculation.minusAction()
        case "/":
            calculation.dividAction()
        case "x":
            calculation.mulitiplyAction()
        case "=":
            calculation.equalAction()
        default:
            break
        }
    }

    //displays an alert message to start a new calculation
    @objc func displayNewCalculation() {
        showErrorPopup(title: "Zéro", message: "Démarrez un  nouveau calcul")
    }
    
    //displays an alert message to type a correct expression
    @objc func displayExpressionAlert() {
        showErrorPopup(title: "Zéro", message: "Expression incorrecte")
    }
    
    //display and alert message for the division by zero
    @objc func dividByZero() {
        showErrorPopup(title: "Zéro", message: "Impossible de diviser par zéro")
    }
    
    //adds the result of an operation to the current displayed text
    @objc func displayTotal() {
        textView.text = textView.text + "=\(calculation.total)"
        calculation.clear()
    }
    
    //displays the inputs of the user (numbers and operators) into the view
    @objc func updateTextDisplay() {
        textView.text = calculation.text
        calculation.text = ""
    }

}
