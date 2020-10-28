//
//  ViewController.swift
//  Tipsy
//
//  Created by Harry Wright on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var numberOfPeople : Int = 2
    var pctTip : Double = 1
    var pctTipValue : String = ""
    var amountPerPerson : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            initialiseHideKeyboard()
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        if sender.tag == 1 {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            pctTip = 1
            pctTipValue = "no tip."
        } else if sender.tag == 2 {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            pctTip = 1.1
            pctTipValue = "10% tip."
        } else {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            pctTip = 1.2
            pctTipValue = "20 % tip."
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        numberOfPeople = Int(sender.value)
        
        splitNumberLabel.text = "\(numberOfPeople)"
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let userInput = billTextField.text ?? ""
        let billAmount = Double(userInput) ?? 0.0
        
        amountPerPerson = String(format: "%.2f", (billAmount * pctTip) / Double(numberOfPeople))
        
        print("£\(amountPerPerson)")
        
        performSegue(withIdentifier: "toResultsPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultsPage" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalText = "£\(amountPerPerson)"
            destinationVC.settingsText = "Split between \(numberOfPeople) people, with \(pctTipValue)"
        }
    }
    
}


// Allows the keyboard to dismiss when the user taps elsewhere
extension CalculatorViewController {
    
    func initialiseHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
        @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
        }
}
