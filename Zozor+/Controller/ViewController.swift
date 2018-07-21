//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let calculation = Calculation()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!


    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calculation.addNewNumber(i)
            }
        }
    }

    @IBAction func plus() {
        if calculation.canAddOperator {
        	calculation.operators.append("+")
        	calculation.stringNumbers.append("")
            calculation.updateDisplay()
        }
    }

    @IBAction func minus() {
        if calculation.canAddOperator {
            calculation.operators.append("-")
            calculation.stringNumbers.append("")
            calculation.updateDisplay()
        }
    }

    @IBAction func equal() {
        calculation.calculateTotal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    private func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextDisplay), name: .text, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayNewCalculation), name: .calculationAlert, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayExpressionAlert), name: .expressionAlert, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayTotal), name: .total, object: nil)
    }
    
    @objc func displayNewCalculation() {
        showErrorPopup(title: "Zéro", message: "Démarrez un nouveau calcule")
    }
    
    @objc func displayExpressionAlert() {
        showErrorPopup(title: "Zéro", message: "Expression incorrecte")
    }
    
    @objc func displayTotal() {
        textView.text = textView.text + "=\(calculation.total)"
        calculation.clear()
    }
    
    @objc func updateTextDisplay() {
        textView.text = calculation.text
        calculation.text = ""
    }

}
