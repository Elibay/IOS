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
    var lastValue = ""
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var HistoryLabel: UILabel!
    
    @IBAction func toZero(_ sender: UIButton) {
        brain = CalculatorBrain()
        isDigitClick = false
        displayLabel.text = "0"
        HistoryLabel.text = ""
        lastOperation = ""
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
            return Double(displayLabel.text!)! }
        set {
            let formatter = NumberFormatter()
            formatter.maximumSignificantDigits = 10
            displayLabel.text = formatter.string(from: newValue as NSNumber)
        }
    }
    func addDigit(_ numberToAdd: Double) {
        let formatter = NumberFormatter()
        formatter.maximumSignificantDigits = 10
        let curentHistoryText = HistoryLabel.text!.replacingOccurrences(of: "...", with: "")
        let textToAdd = curentHistoryText.replacingOccurrences(of: "=", with: "") + formatter.string(from: numberToAdd as NSNumber)!
        HistoryLabel.text = textToAdd + "..."
        lastValue = formatter.string(from: numberToAdd as NSNumber)!
    }
    func addSymbol(_ symbol: String) {
        let text2 = HistoryLabel.text!.replacingOccurrences(of: "...", with: "")
        let text1 = text2.replacingOccurrences(of: "=", with: "")
        if text1 == "" {
            return
        }
        var curentHistoryText = ""
        switch symbol {
        case "√":
            if lastOperation != "=" {
                let index = text1.index(text1.startIndex, offsetBy: text1.characters.count - lastValue.characters.count)
                curentHistoryText = text1.substring(to: index) + symbol + "(" + lastValue + ")"
            }
            else {
                curentHistoryText = symbol + "(" + text1 + ")"
            }
        case "+":
            if text1.characters.last! >= "0" && text1.characters.last! <= "9" {
                curentHistoryText = text1 + symbol
            }
            else {
                curentHistoryText = text1.substring(to: text1.index(before: text1.endIndex)) + symbol
            }
        case "-":
            if text1.characters.last! >= "0" && text1.characters.last! <= "9" {
                curentHistoryText = text1 + symbol
            }
            else {
                curentHistoryText = text1.substring(to: text1.index(before: text1.endIndex)) + symbol
            }
        case "=":
            if text1.characters.last! >= "0" && text1.characters.last! <= "9" {
                curentHistoryText = text1 + symbol
            }
            else {
                curentHistoryText = text1.substring(to: text1.index(before: text1.endIndex)) + symbol
            }
        default:
            if text1.characters.last! >= "0" && text1.characters.last! <= "9" {
                curentHistoryText = "(" + text1 + ")" + symbol
            }
            else {
                if text1.characters.last! == "×" || text1.characters.last! == "÷" {
                    curentHistoryText = text1.substring(to: text1.index(before: text1.endIndex)) + symbol
                }
                else {
                    curentHistoryText = "(" + text1.substring(to: text1.index(before: text1.endIndex)) + ")" + symbol
                }
            }
        }
        HistoryLabel.text = curentHistoryText
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
    
    
    @IBAction func PressOperations(_ sender: UIButton) {
        if isDigitClick == true {
            addDigit(displayValue)
            brain.setOperation(displayValue)
            isDigitClick = false
        }
        if let operation = sender.currentTitle {
            brain.performOperation(operation)
            addSymbol(operation)
            lastOperation = operation
            if let result = brain.result {
                displayValue = result
            }
            
        }
    }
}
