//
//  ViewController.swift
//  Concentration
//
//  Created by Deepanshu Yadav on 11/11/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count+1)/2)
    
    @IBOutlet weak var scoreCardLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var cardColor = UIColor()
    var bgColor = UIColor()
    var emojiChoices = [String]()
    var themes = [["🌚","👻","👹","🎃","😈","💀","🙀","😱","☠️"],["🐶","🐒","🐰","🐻","🐼","🐸","🙀","🐍","🦄"],["💦","🍆","🍑","🌈","👅","👄","🤗","🤤","🍒"]]
    var themeCardColor = [UIColor.orange,UIColor.green,UIColor.systemPink]
    
    
    func selectTheme(numberOfThemes theme:Int) {
        var randomIndex = 0
        for _ in 0..<theme {
            randomIndex = Int(arc4random_uniform(UInt32(theme)))
        }
        emojiChoices = themes[randomIndex]
        cardColor = themeCardColor[randomIndex]
        bgColor = UIColor.black
        view.backgroundColor = bgColor
        flipCountLabel.textColor = cardColor
        scoreCardLabel.textColor = cardColor
        newGameButton.backgroundColor = cardColor
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = cardColor
        }
        
    }
    override func viewDidLoad() {
        selectTheme(numberOfThemes: themes.count)
    }
    
    
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
    
    @IBAction func startNewGame(_ sender: UIButton) {
        for index in game.cards.indices {
            game.cards[index].isMatched = false
            game.cards[index].isFacedUp = false
            flipCountLabel.text = "0"
            scoreCardLabel.text = "0"
            selectTheme(numberOfThemes: themes.count)
            updateViewFromModel()
        }
        game = Concentration(numberOfPairsOfCard: (cardButtons.count+1)/2)
    }
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)  : cardColor
            }
        }
    }
    
    var emoji = [Int : String]()
    
    func emoji(for card:Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count>0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "X"
    }
}

