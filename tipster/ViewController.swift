//
//  ViewController.swift
//  tipster
//
//  Created by Rodrigo Bell on 11/27/16.
//  Copyright © 2016 Rodrigo Bell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    let formatter = NumberFormatter()
    let locale = Locale.current
    
    let tipPercents = [0.18, 0.2, 0.25]
    var bill : Double = 0.00
    var tip : Double = 0.00
    var total : Double = 0.00
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var numPeopleControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipControl.selectedSegmentIndex = userDefaults.integer(forKey: "tipDefault")
        
        billField.placeholder = "\(locale.currencySymbol!)0.00"
        billField.becomeFirstResponder()
        billField.addTarget(self, action: #selector(billFieldDidChange), for: .editingChanged)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tipControl.selectedSegmentIndex = userDefaults.integer(forKey: "tipDefault")
        calculateTip(nil)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject?) {
        let curTip = tipControl.selectedSegmentIndex
        
        tip = bill * tipPercents[curTip]
        total = bill + tip
        
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = locale.currencySymbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        if let tipString = formatter.string(from: NSNumber(value: tip)) {
            tipLabel.text = tipString
        }
        
        calculateTotal(nil)
    }
    
    @IBAction func calculateTotal(_ sender: AnyObject?) {
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = locale.currencySymbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        if let totalString = formatter.string(from: NSNumber(value: total)) {
            totalLabel.text = totalString
        }
        
        switch numPeopleControl.selectedSegmentIndex {
        case 1:
            let subtotal = total / 2
            if let subtotalString = formatter.string(from: NSNumber(value: subtotal)) {
                subtotalLabel.text = subtotalString
            }
        case 2:
            let subtotal = total / 3
            if let subtotalString = formatter.string(from: NSNumber(value: subtotal)) {
                subtotalLabel.text = subtotalString
            }
        case 3:
            let subtotal = total / 4
            if let subtotalString = formatter.string(from: NSNumber(value: subtotal)) {
                subtotalLabel.text = subtotalString
            }
        default:
            let subtotal = total
            if let subtotalString = formatter.string(from: NSNumber(value: subtotal)) {
                subtotalLabel.text = subtotalString
            }
        }
    }
    
    func billFieldDidChange(_ textField: UITextField) {
        if var amountString = billField.text?.currencyInputFormatting() {
            billField.text = amountString
            if (amountString != "") {
                amountString.remove(at: amountString.startIndex)
                amountString = amountString.replacingOccurrences(of: ",", with: "")
                amountString = amountString.replacingOccurrences(of: ".", with: "")
                amountString = amountString.trimmingCharacters(in: .whitespaces)
                bill = Double(amountString)!
            } else {
                bill = 0.00
            }
            calculateTip(nil)
        }
    }
}

extension String {
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
