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
    let tipPercents = [0.18, 0.2, 0.25]
    var bill : Double = 0.00
    var tip : Double = 0.00
    var total : Double = 0.00
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var numPeopleControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipControl.selectedSegmentIndex = userDefaults.integer(forKey: "tipDefault")
        billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tipControl.selectedSegmentIndex = userDefaults.integer(forKey: "tipDefault")
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let curTip = tipControl.selectedSegmentIndex
        
        bill = Double(billField.text!) ?? 0
        tip = bill * tipPercents[curTip]
        total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        
        calculateTotal(nil)
    }
    @IBAction func calculateTotal(_ sender: AnyObject?) {
        switch numPeopleControl.selectedSegmentIndex {
        case 0:
            totalLabel.text = String(format: "$%.2f", total)
        case 1:
            totalLabel.text = String(format: "$%.2f", total/2)
        case 2:
            totalLabel.text = String(format: "$%.2f", total/3)
        case 3:
            totalLabel.text = String(format: "$%.2f", total/4)
        default:
            totalLabel.text = String(format: "$%.2f", total)
        }
        
    }
    
}
