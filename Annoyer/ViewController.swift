//
//  ViewController.swift
//  Annoyer
//
//  Created by Tyler Knox on 8/30/17.
//  Copyright © 2017 tyler58546. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    @IBOutlet weak var ttsField: NSTextField!
    @IBOutlet weak var voiceSelector: NSPopUpButton!
    @IBOutlet weak var freqSelector: NSSlider!
    @IBOutlet weak var freqPlayButton: NSButton!
    @IBOutlet weak var armCB: NSButton!
    @IBOutlet weak var versionText: NSTextField!
    
    var tonePlayer: AVAudioPlayer!
    
    let loop = RunLoop.current
    let synth = NSSpeechSynthesizer()
    func speech(text: String) {
        synth.startSpeaking(text)
        let mode = loop.currentMode ?? RunLoopMode.defaultRunLoopMode
        while loop.run(mode: mode, before: NSDate(timeIntervalSinceNow: 0.1) as Date)
            && synth.isSpeaking {}
    }
    @IBAction func valueChanged(_ sender: NSPopUpButton) {
        let newVoice = voiceSelector.selectedItem?.title
        
        
        for v in NSSpeechSynthesizer.availableVoices {
            let attrs = NSSpeechSynthesizer.attributes(forVoice: v)
            if attrs[NSSpeechSynthesizer.VoiceAttributeKey.name] as? String == newVoice {
                synth.setVoice(v)
                break
            }
        }
    }
    @IBAction func freqPlayButtonPressed(_ sender: Any) {
        let freq = freqSelector.doubleValue
        var file = "1000hz.wav"
        
        if (freq == 0) {file = "1000hz.wav"}
        if (freq == 1) {file = "5000hz.wav"}
        if (freq == 2) {file = "10000hz.wav"}
        if (freq == 3) {file = "15000hz.wav"}
        
        let path = Bundle.main.path(forResource: file, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            tonePlayer = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        speech(text: ttsField.stringValue)
    }
    @IBAction func ArmCheck(_ sender: NSButton) {
        
        switch sender.state {
        case NSControl.StateValue.on:
            freqPlayButton.isEnabled = true
        case NSControl.StateValue.off:
            freqPlayButton.isEnabled = false
        default:
            freqPlayButton.isEnabled = false
        }
    }
    lazy var TermsView: NSViewController = {
        return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "TermsViewController"))
            as! NSViewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ///LOAD PREFRENCES
        let defaults = UserDefaults.standard
        let pref_autoArm = defaults.object(forKey: "autoArm") as? Bool ?? Bool()
        let pref_defaultVoice = defaults.object(forKey: "defaultVoice") as? Int ?? Int()
        let pref_customVoices = defaults.object(forKey: "customVoices") as? Bool ?? Bool()
        let pref_defaultText = defaults.object(forKey: "defaultText") as? String ?? String()
        if (pref_autoArm) {
            armCB.state = NSControl.StateValue.on
            freqPlayButton.isEnabled = true
        }
        if (pref_customVoices) {
            voiceSelector.isEnabled = true
            voiceSelector.selectItem(at: pref_defaultVoice)
            let newVoice = voiceSelector.selectedItem?.title
            for v in NSSpeechSynthesizer.availableVoices {
                let attrs = NSSpeechSynthesizer.attributes(forVoice: v)
                if attrs[NSSpeechSynthesizer.VoiceAttributeKey.name] as? String == newVoice {
                    synth.setVoice(v)
                    break
                }
            }
            
        }
        ttsField.stringValue = pref_defaultText
        
        // Set version number indicator
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String
        versionText.stringValue = "v\(version!) by tyler58546"
    }
    override func viewDidAppear() {
        if (UserDefaults.standard.object(forKey: "Terms") as? Bool != true) {
            
            self.presentViewControllerAsSheet(TermsView)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

