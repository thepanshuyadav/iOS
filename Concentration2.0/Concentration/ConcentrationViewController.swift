//
//  ViewController.swift
//  Concentration
//
//  Created by Deepanshu Yadav on 11/11/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count+1)/2)
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    var flipCount = 0{
        didSet {
            flipCountLabel.text = "Flips : \(flipCount)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Error")
        }
        
    }
    
    func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFacedUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)  : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
        
    }
    var theme : String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    var emoji = [Int : String]()
    var emojiChoices = "🌚👻👹🎃😈💀🙀😱☠️"
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count>0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int(arc4random_uniform(UInt32(emojiChoices.count))))
            emoji[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card.identifier] ?? "X"
    }
}

