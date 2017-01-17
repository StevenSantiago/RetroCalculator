//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Steven Santiago on 1/17/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit
import AVFoundation// used for adding sounds to button in this case

class ViewController: UIViewController {
    
    var btnSound : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // code to add audio to button
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }


}

