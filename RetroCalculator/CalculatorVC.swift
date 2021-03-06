//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Steven Santiago on 1/17/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//
import UIKit
import AVFoundation// used for adding sounds to button in this case

class CalculatorVC: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private let INVALID = 0
    private let VALID = 1
    
    private var userInMiddleOfTyping = false
    
    private var displayValue : Double {// used to convert button to double, or string to double and back after computing
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    
    private var btnSound : AVAudioPlayer!
    
    private var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    @IBAction private func numberPressed(sender: UIButton) {
        playSound()
        let digit = sender.currentTitle!
        if userInMiddleOfTyping {
            var textCurrentlyInDisplay = ""
            if display.text!.contains("Not Valid Syntax") == false {
                textCurrentlyInDisplay = display.text!
            }
            display.text = textCurrentlyInDisplay + digit
            if (decimalCheck() == INVALID) {
                textCurrentlyInDisplay = ""
            }
        } else {
            display.text = digit
        }
        userInMiddleOfTyping = true
        
    }
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if display.text!.contains("Not Valid Syntax") == false { // only proceed with operation if valid syntax
            if userInMiddleOfTyping { // bring in operand to calculator brain
                brain.setOperand(operand: displayValue)
                userInMiddleOfTyping = false
            }
            if let mathematicalSymbol = sender.currentTitle {
                brain.performOperation(symbol: mathematicalSymbol)
            }
            displayValue = brain.result // updating display value
        }
    }
    
    
    
    private func decimalCheck() -> Int { // used to check if decimal is inputted and is formatted correctly
        var decimals = 0
        if display.text!.contains("."){
            for i in display.text!.characters{
                if i == "." {
                    decimals = decimals + 1
                }
            }
            if decimals >= 2 {
                display.text = "Not Valid Syntax"
                return INVALID
            } else {
                return VALID // meaning valid decimal syntax
            }
        }else {
            return VALID // return valid because no decimal was found
        }
    }
    
    
    private func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
}

