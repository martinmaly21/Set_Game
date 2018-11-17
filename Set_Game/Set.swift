//
//  Set.swift
//  Set_Game
//
//  Created by Martin Maly on 2018-11-10.
//  Copyright © 2018 Martin Maly. All rights reserved.
//

import Foundation
import UIKit
class Set {//i can use Count property on cards array (below), since it will always know the number of cards given/still avaailible
var cards = [Card]()
var score = 0

    func checkIfWin(threeSelectedCards: [UIButton]) -> Bool {
        var seeIfMatch: Bool = false
        //perform logic if there is a match then we have to do some shit!
        let firstCard = threeSelectedCards[0]
        let secondCard = threeSelectedCards[1]
        let thirdCard = threeSelectedCards[2]
        
        if (gameDictionary[firstCard]?.cardColour == gameDictionary[secondCard]?.cardColour && gameDictionary[secondCard]?.cardColour == gameDictionary[thirdCard]?.cardColour) || (gameDictionary[firstCard]?.cardColour != gameDictionary[secondCard]?.cardColour && gameDictionary[secondCard]?.cardColour != gameDictionary[thirdCard]?.cardColour) {
         if (gameDictionary[firstCard]?.cardShape == gameDictionary[secondCard]?.cardShape && gameDictionary[secondCard]?.cardShape == gameDictionary[thirdCard]?.cardShape) || (gameDictionary[firstCard]?.cardShape != gameDictionary[secondCard]?.cardShape && gameDictionary[secondCard]?.cardShape != gameDictionary[thirdCard]?.cardShape) {
        if (gameDictionary[firstCard]?.cardNumberOfElement == gameDictionary[secondCard]?.cardNumberOfElement && gameDictionary[secondCard]?.cardNumberOfElement == gameDictionary[thirdCard]?.cardNumberOfElement) || (gameDictionary[firstCard]?.cardNumberOfElement != gameDictionary[secondCard]?.cardNumberOfElement && gameDictionary[secondCard]?.cardNumberOfElement != gameDictionary[thirdCard]?.cardNumberOfElement) {
        if (gameDictionary[firstCard]?.cardFillType == gameDictionary[secondCard]?.cardFillType && gameDictionary[secondCard]?.cardFillType == gameDictionary[thirdCard]?.cardFillType) || (gameDictionary[firstCard]?.cardFillType != gameDictionary[secondCard]?.cardFillType && gameDictionary[secondCard]?.cardFillType != gameDictionary[thirdCard]?.cardFillType) {
            
            //This is where i say what to do if it is a set
            //I can replace cards in set here too???
            self.score += 6
            gameDictionary[firstCard] = Card()
            gameDictionary[secondCard] = Card()
            gameDictionary[thirdCard] = Card()
            seeIfMatch = true
            
        }
        }
        }
        }
        self.score -= 1
        //no need to replace cards
        //this is what i do if its not a set
        let _ = firstCard.layer.sublayers?.popLast()
        let _ = secondCard.layer.sublayers?.popLast()
        let _ = thirdCard.layer.sublayers?.popLast()
        return seeIfMatch
    }
    
    func initializeThreeMoreCards() -> [Card] {
        var tempArray: [Card] = []
        for _ in 1...3 {
            let card = Card()
            cards.append(card)
            tempArray.append(card)
        }
        return tempArray
    }
    
    init() {
        //so when we initialize a new game of 'Set' by Set(), we are getting twelve cards
        for _ in 1...12 {
            let card = Card()
            cards.append(card)
        }
    }
}



