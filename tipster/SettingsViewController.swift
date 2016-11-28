//
//  settingsViewController.swift
//  tipster
//
//  Created by Rodrigo Bell on 11/27/16.
//  Copyright © 2016 Rodrigo Bell. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print(userDefaults.integer(forKey: "tipDefault"))
        defaultTipControl.selectedSegmentIndex = userDefaults.integer(forKey: "tipDefault")
    }
    
    @IBAction func changeDefaultTip(_ sender: Any) {
        let defaultTip = defaultTipControl.selectedSegmentIndex
        userDefaults.set(defaultTip, forKey: "tipDefault")
    }
    
}
