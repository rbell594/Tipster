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
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipControl.selectedSegmentIndex = userDefaults.integer(forKey: "tipDefault")
        billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let curTip = tipControl.selectedSegmentIndex
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercents[curTip]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)    }

}
