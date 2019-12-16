//
//  Concentration.swift
//  Concentration
//
//  Created by Deepanshu Yadav on 06/12/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score+=2
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
                score -= 1
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
        for _ in 0..<numberOfPairsOfCard {
            let card = Card()
            cards += [card,card]
            cards.shuffle()
        }
    }
}
