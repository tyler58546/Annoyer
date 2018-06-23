//
//  ViewController2.swift
//  Annoyer
//
//  Created by Tyler Knox on 8/31/17.
//  Copyright © 2017 tyler58546. All rights reserved.
//

import Cocoa

class ViewController2: NSViewController {
    @IBOutlet weak var pwField: NSSecureTextField!

    @IBAction func quitButtonPressed(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    @IBAction func unlockButtonPressed(_ sender: Any) {
        let pwEntered = pwField.stringValue
        if (pwEntered == "passw0rd") {
            //Unlock Application
            dismiss(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
