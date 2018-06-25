//
//  TermsViewController.swift
//  Annoyer
//
//  Created by Tyler Knox on 6/25/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import Cocoa

class TermsViewController: NSViewController {
    @IBAction func agree_click(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "Terms")
        self.dismissViewController(self)
    }
    @IBAction func quit_click(_ sender: Any) {
        //Quit application
        self.dismissViewController(self)
        NSApplication.shared.terminate(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
