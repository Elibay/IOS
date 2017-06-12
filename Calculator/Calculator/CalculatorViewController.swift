//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Elibay Nuptebek on 12.06.17.
//  Copyright © 2017 Elibay Nuptebek. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var isDigitClick = false;
    @IBAction func PressDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let curentDisplaytext = displayLabel.text!
        if !isDigitClick
        {
            displayLabel.text = digit
            isDigitClick = true;
        }
        else
        {
            if curentDisplaytext == "0"
            {
                displayLabel.text = digit
            }
            else
            {
                displayLabel.text = curentDisplaytext + digit
            }
        }
        
    }
    var displayValue: Double {
        get { return Double(displayLabel.text!)! }
        set { displayLabel.text = String(newValue) }
    }
    @IBAction func PressOperations(_ sender: UIButton) {
        if let operation = sender.currentTitle
        {
            switch operation {
                case "π":
                    displayLabel.text = String (Double.pi);
                case "√":
                    displayValue = sqrt (displayValue)
                case "AC":
                    displayLabel.text = "0"
                default:
                    break;
            }
        }
    }
}
