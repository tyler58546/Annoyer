//
//  SettingsWindow.swift
//  Annoyer
//
//  Created by Tyler Knox on 2/24/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import Cocoa

class SettingsWindow: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        ///LOAD PREFRENCES
        let defaults = UserDefaults.standard
        let pref_autoArm = defaults.object(forKey: "autoArm") as? Bool ?? Bool()
        let pref_defaultVoice = defaults.object(forKey: "defaultVoice") as? Int ?? Int()
        let pref_customVoices = defaults.object(forKey: "customVoices") as? Bool ?? Bool()
        let pref_defaultText = defaults.object(forKey: "defaultText") as? String ?? String()
        if (pref_autoArm) {
            autoArm.state = NSOnState
        }
        if (pref_customVoices) {
            defaultVoice.isEnabled = true
            defaultVoice.selectItem(at: pref_defaultVoice)
        }
        defaultText.stringValue = pref_defaultText
    }
    override func viewDidAppear() {
        // any additional code
        view.window!.styleMask.remove(NSWindow.StyleMask.resizable)
    }
    ///OUTLETS
    @IBOutlet weak var cvCheck: NSButton!
    @IBOutlet weak var defaultVoice: NSPopUpButton!
    @IBOutlet weak var autoArm: NSButton!
    @IBOutlet weak var defaultText: NSTextField!
    ///ACTIONS
    @IBAction func saveSettings(_ sender: Any) {
        var pref_autoArm = false
        switch autoArm.state {
        case NSOnState:
            pref_autoArm = true
        case NSOffState:
            pref_autoArm = false
        default:
            pref_autoArm = false
        }
        let pref_defaultVoice = defaultVoice.indexOfSelectedItem
        var pref_customVoices = false
        switch cvCheck.state {
        case NSOnState:
            pref_customVoices = true
        case NSOffState:
            pref_customVoices = false
        default:
            pref_customVoices = false
        }
        let pref_defaultText = defaultText.stringValue
        
        let defaults = UserDefaults.standard
        defaults.set(pref_autoArm, forKey: "autoArm")
        defaults.set(pref_defaultVoice, forKey: "defaultVoice")
        defaults.set(pref_customVoices, forKey: "customVoices")
        defaults.set(pref_defaultText, forKey: "defaultText")
        self.view.window?.close()
    }
    @IBAction func cancelSettings(_ sender: Any) {
        self.view.window?.close()
    }
    @IBAction func cvCheckClick(_ sender: Any) {
        switch cvCheck.state {
        case NSOnState:
            defaultVoice.isEnabled = true
        case NSOffState:
            defaultVoice.isEnabled = false
            defaultVoice.selectItem(at: 0)
        default:
            defaultVoice.isEnabled = false
            defaultVoice.selectItem(at: 0)
        }
    }
    
}
