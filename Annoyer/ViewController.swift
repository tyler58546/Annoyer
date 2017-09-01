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
    
    var onekhz: AVAudioPlayer!
    
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
        
        
        for v in NSSpeechSynthesizer.availableVoices() {
            let attrs = NSSpeechSynthesizer.attributes(forVoice: v)
            if attrs["VoiceName"] as? String == newVoice {
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
            onekhz = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        speech(text: ttsField.stringValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //speech(text: "hi")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

