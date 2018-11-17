//
//  card.swift
//  Set_Game
//
//  Created by Martin Maly on 2018-11-10.
//  Copyright © 2018 Martin Maly. All rights reserved.
//
import UIKit
import Foundation



var usedCards: [[Int]] = []
class Card {
    var cardFillType: Int = 0
    var cardNumberOfElement: Int = 0
    var cardShape: Int = 0
    var cardColour: Int = 0
    var isMatched: Bool = false
    
    init() {
        
        while (true) {
            let fillType = Int.random(in: 1...3)
            let numberOfElement = Int.random(in: 1...3)
            let shape = Int.random(in: 1...3)
            let colour = Int.random(in: 1...3)
            let card = [fillType, numberOfElement, shape, colour]
            
            if usedCards.contains(card) {
                continue
            } else {
                usedCards.append(card)
                self.cardFillType = fillType
                self.cardNumberOfElement = numberOfElement
                self.cardShape = shape
                self.cardColour = colour
                break
            }
        }
    }

}
