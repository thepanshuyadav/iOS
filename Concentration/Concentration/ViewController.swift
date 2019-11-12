//
//  ViewController.swift
//  Concentration
//
//  Created by Deepanshu Yadav on 11/11/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0{
        didSet {
            flipCountLabel.text = "Flips : \(flipCount)"
        }
    }
    var emojiChoices = ["🌚","👻","👻","🌚"]
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(emoji: emojiChoices[cardNumber], button: sender)
        } else {
            print("Error")
        }
        
    }
    

    func flipCard(emoji: String, button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

