//
//  ViewController.swift
//  IOS_Codepath_Prework
//
//  Created by Andy Chen on 1/13/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    let defaults = UserDefaults.standard

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        // Get default tip percentages
        tipControl.setTitle(defaults.string(forKey: "defaultTipTextField") ?? "15%", forSegmentAt: 0)
        tipControl.setTitle(defaults.string(forKey: "defaultTipTextField2") ?? "18%", forSegmentAt: 1)
        tipControl.setTitle(defaults.string(forKey: "defaultTipTextField3") ?? "20%", forSegmentAt: 2)
        
        // Calculate tip after settings change
        calculateTip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        // Show keyboard on load
        billAmountTextField.becomeFirstResponder()
        
        // Sets the title in the Navigation Bar
            self.title = "Tip Calculator"
        
    }
    
    
    @IBOutlet weak var tipPercentageTitleLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var customTipSwitch: UISwitch!
    
    
    @IBAction func customTipSwitchChanged(_ sender: Any) {
        if customTipSwitch.isOn {
            tipPercentageTitleLabel.isHidden = false
            tipPercentageLabel.isHidden = false
            tipPercentageSlider.isHidden = false
            tipControl.isHidden = true
        } else {
            tipPercentageTitleLabel.isHidden = true
            tipPercentageLabel.isHidden = true
            tipPercentageSlider.isHidden = true
            tipControl.isHidden = false
        }
    }

    @IBAction func tipPercentageSliderChanged(_ sender: Any) {
        // Round slider values to integers
        (sender as AnyObject).setValue((sender as AnyObject).value.rounded(.down), animated: true)
        
        // Show percentage
        tipPercentageLabel.text = String(Int(tipPercentageSlider.value))  + "%"
    }
    
    @IBAction func calculateTip() {
        // Get bill amount from text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Get Total Tip by multiplying tip * tipPercentage
        var tipPercentages: [Double] = [0.0, 0.0, 0.0]
        
        tipPercentages[0] = convertTiptoDouble(tipString: tipControl.titleForSegment(at: 0) ?? "0.0")
        tipPercentages[1] = convertTiptoDouble(tipString: tipControl.titleForSegment(at: 1) ?? "0.0")
        tipPercentages[2] = convertTiptoDouble(tipString: tipControl.titleForSegment(at: 2) ?? "0.0")
        
        // Get Total Tip by control segment or slider
        var tip: Double = 0.0
        if customTipSwitch.isOn {
            tip =  bill * Double(tipPercentageSlider.value) * 0.01
        }else {
            tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        }
        let total = bill + tip
        
        // Update tip amount label
        tipAmountLabel.text = String(format: "$%.2f", tip)
        // Update total amount label
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func convertTiptoDouble(tipString: String) -> Double {
        let newString = tipString.replacingOccurrences(of: "%", with: "")
        return (Double(newString) ?? 0.0) * 0.01
    }
    
   
}

