//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Elibay Nuptebek on 12.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var brain = CalculatorBrain()
    var isDigitClick = false
    var lastOperation = ""
    var lastValue: Double? = 0
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var HistoryLabel: UILabel!
    
    @IBAction func toZero(_ sender: UIButton) {
        brain = CalculatorBrain()
        isDigitClick = false
        displayLabel.text = "0"
        HistoryLabel.text = ""
        lastOperation = ""
    }
    @IBAction func PressDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let curentDisplaytext = displayLabel.text!
        if !isDigitClick {
            displayLabel.text = digit
            isDigitClick = true;
        }
        else {
            if curentDisplaytext == "0" {
                displayLabel.text = digit
            }
            else {
                displayLabel.text = curentDisplaytext + digit
            }
        }
        
    }
    
    @IBAction func touchDot(_ sender: UIButton) {
        var text = displayLabel.text!
        if text.characters.index (of: ".") != nil {
            return
        }
        text += "."
        displayLabel.text = text
        
    }
    var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            let formatter = NumberFormatter()
            formatter.maximumSignificantDigits = 10
            displayLabel.text = formatter.string(from: newValue as NSNumber)
        }
    }
    var historyValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            let formatter = NumberFormatter()
            formatter.maximumSignificantDigits = 10
            let text1 = HistoryLabel.text!
            let text2 = formatter.string(from: newValue as NSNumber)
            var textl = ""
            if text1.characters.count >= 1 {
                switch lastOperation {
                case "√":
                    let index = text1.index(text1.startIndex, offsetBy: text1.characters.count - text2!.characters.count - 1)
                    textl = text1.substring(to: index) + lastOperation + "(" + text2! + ")" + "⋯"
                case "÷":
                    textl = "(" + text1.substring(to: text1.index(before: text1.endIndex)) + ")" + lastOperation + text2! + "⋯"
                case "×":
                    textl = "(" + text1.substring(to: text1.index(before: text1.endIndex)) + ")" + lastOperation + text2! + "⋯"
                case "=":
                    print ("h")
                    textl = text1.substring(to: text1.index(before: text1.endIndex)) + "="
                default:
                    textl = text1.substring(to: text1.index(before: text1.endIndex)) + lastOperation + text2! + "⋯"
                }
                
            }
            else
            {
                print ("asdf")
                if lastOperation != "="
                {
                    textl = text1 + lastOperation + text2! + "⋯"
                }
            }
            HistoryLabel.text = textl
        }
    }
    
    @IBAction func PressOperations(_ sender: UIButton) {
        if isDigitClick == true {
            brain.setOperation(displayValue)
            isDigitClick = false
            lastValue = displayValue
        }
        if let operation = sender.currentTitle {
            if operation == "√" {
                if lastValue != nil
                {
                    historyValue = lastValue!
                    lastOperation = operation
                    historyValue = lastValue!
                    lastValue = nil
                }
            }
            else
            {
                if lastOperation != "√" && lastValue != nil {
                    historyValue = lastValue!
                    lastValue = nil
                }
                lastOperation = operation
                
            }
            brain.performOperation(operation)
            if let result = brain.result {
                displayValue = result
            }
            
        }
    }
}
