//
//  Card.swift
//  Concentration
//
//  Created by Deepanshu Yadav on 06/12/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import Foundation

struct Card
{
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}