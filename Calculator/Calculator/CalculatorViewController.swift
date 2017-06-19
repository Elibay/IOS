//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Elibay Nuptebek on 12.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class CalculatorViewController: UIViewController {

    var brain = CalculatorBrain()
    var isDigitClick = false
    var lastOperation = ""
    var lastValue = ""
    var sumSqrt = 0
    var pressedDigit = false
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
    func isDigit (_ character: Character) -> Bool {
        if character >= "0" && character <= "9" {
            return true
        }
        return false
    }
    func addDigit(_ numberToAdd: Double) {
        let formatter = NumberFormatter()
        formatter.maximumSignificantDigits = 10
        let curentHistoryText = HistoryLabel.text!.replacingOccurrences(of: "=", with: "")
        if curentHistoryText.characters.count == 0 || (isDigit (curentHistoryText.characters.last!) == false && lastOperation != "√" && lastOperation != "π"){
            print (lastOperation)
            let textToAdd = curentHistoryText + formatter.string(from: numberToAdd as NSNumber)!
            HistoryLabel.text = textToAdd + "..."
        }
        else {
            HistoryLabel.text = formatter.string(from: numberToAdd as NSNumber)!
        }
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
            if lastOperation == "√" {
                let index = text1.index(text1.startIndex, offsetBy: text1.characters.count - lastValue.characters.count - sumSqrt)
                curentHistoryText = text1.substring(to: index) + symbol + "(" + lastValue + ")"
                for _ in 1...sumSqrt {
                    curentHistoryText = curentHistoryText + ")"
                }
            }
            else if pressedDigit == false {
                curentHistoryText = text1 + symbol + "(" + text1.substring(to: text1.index(before: text1.endIndex)) + ")"
            }
            else if lastOperation != "=" {
                let index = text1.index(text1.startIndex, offsetBy: text1.characters.count - lastValue.characters.count)
                curentHistoryText = text1.substring(to: index) + symbol + "(" + lastValue + ")"
            }
            else {
                curentHistoryText = symbol + "(" + text1 + ")"
            }
            sumSqrt += 1
        case "+":
            if text1.characters.last! >= "0" && text1.characters.last! <= "9" || text1.characters.last! == ")"{
                curentHistoryText = text1 + symbol
            }
            else {
                curentHistoryText = text1.substring(to: text1.index(before: text1.endIndex)) + symbol
            }
        case "π":
            if lastOperation == "π" {
                return
            }
            if text1.characters.last! == "+" || text1.characters.last! == "-" || text1.characters.last! == "×" || text1.characters.last! == "÷"{
                curentHistoryText = text1 + symbol
            }
            else {
                curentHistoryText = symbol
            }
        case "-":
            if text1.characters.last! >= "0" && text1.characters.last! <= "9" || text1.characters.last! == ")" {
                curentHistoryText = text1 + symbol
            }
            else {
                curentHistoryText = text1.substring(to: text1.index(before: text1.endIndex)) + symbol
            }
        case "=":
            if text1.characters.last! >= "0" && text1.characters.last! <= "9" || text1.characters.last! == ")" {
                curentHistoryText = text1 + symbol
            }
            else {
                curentHistoryText = text1.substring(to: text1.index(before: text1.endIndex)) + symbol
            }
        case "±":
            if text1[0] != "-" {
                if (text1[0] != "(")
                {
                    curentHistoryText = "-(" + text1 + ")"
                }
                else {
                    curentHistoryText = "-" + text1
                }
            }
            else
            {
                curentHistoryText = text1
                curentHistoryText.remove(at: curentHistoryText.startIndex)
            }
        default:
            if text1.characters.last! >= "0" && text1.characters.last! <= "9"  || text1.characters.last! == ")" || text1.characters.last! == "π"{
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
        if symbol != "√" {
            sumSqrt = 0
        }
        HistoryLabel.text = curentHistoryText
    }
    @IBAction func PressDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        pressedDigit = true
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
        pressedDigit = false
    }
}
