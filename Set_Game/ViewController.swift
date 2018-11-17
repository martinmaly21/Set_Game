//
//  ViewController.swift
//  SetGame
//
//  Created by Martin Maly on 2018-11-10.
//  Copyright © 2018 Martin Maly. All rights reserved.
//

import UIKit

var gameDictionary: [UIButton: Card] = [:]
class ViewController: UIViewController {
    @IBOutlet weak var dealMoreCardsButton: UIButton!
    @IBOutlet var setButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    

    var numberOfDeals: Int = 0
    var numberOfCardsTouched: Int = 0
    var game = Set()
    var arrayOfTouchedCards: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialGameSetup()
        updateViewFromModel()
    }

    @IBAction func cardTouched(_ sender: UIButton) {
        //check to see if they are deselecting
        //this is place to update border, NOT logic
        //write function though to check if it is third button clicked
        //to know when to check for win
        //maybe add three cards to array and then pass that array to the model
        //only taking into consideration unselecting the one that was previously selected!!
        let selectedButtonLayer = CAGradientLayer()
        selectedButtonLayer.frame = sender.layer.bounds
        if let cardIndex = setButtons.index(of: sender) {
            if arrayOfTouchedCards.contains(sender) {
                let _ = setButtons[cardIndex].layer.sublayers?.popLast()
                let farray = arrayOfTouchedCards.filter {$0 != sender}
                arrayOfTouchedCards = farray
            } else {
                selectedButtonLayer.borderColor = UIColor(red: 128 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1).cgColor
                selectedButtonLayer.borderWidth = 3.0
                setButtons[cardIndex].layer.addSublayer(selectedButtonLayer)
                arrayOfTouchedCards.append(sender)
            }
        }
        
        if arrayOfTouchedCards.count == 3 {
            if (game.checkIfWin(threeSelectedCards: arrayOfTouchedCards)) {
                setLabel.text = "Set!"
                setLabel.textColor = .black
            } else {
                setLabel.textColor = .red
                setLabel.text = "Not a set!"
            }
            arrayOfTouchedCards.removeAll()
        }
        updateViewFromModel()
    }
    
    @IBAction func dealMoreCards(_ sender: Any) {
        numberOfDeals += 1
        
        if numberOfDeals == 4 {
            dealMoreCardsButton.layer.sublayers = nil
        }
        
        let currentAmountOfCards = gameDictionary.count
        let arrayOfThreeCards = game.initializeThreeMoreCards()
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.colors = [UIColor.white.cgColor,UIColor.white.cgColor]
        gradientLayer1.cornerRadius = 10
        gradientLayer1.shadowOpacity = 0.2
        gradientLayer1.shadowRadius = 10
        gradientLayer1.frame = setButtons[0].bounds
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.colors = [UIColor.white.cgColor,UIColor.white.cgColor]
        gradientLayer2.cornerRadius = 10
        gradientLayer2.shadowOpacity = 0.2
        gradientLayer2.shadowRadius = 10
        gradientLayer2.frame = setButtons[0].bounds
        let gradientLayer3 = CAGradientLayer()
        gradientLayer3.colors = [UIColor.white.cgColor,UIColor.white.cgColor]
        gradientLayer3.cornerRadius = 10
        gradientLayer3.shadowOpacity = 0.2
        gradientLayer3.shadowRadius = 10
        gradientLayer3.frame = setButtons[0].bounds
        gameDictionary[setButtons[currentAmountOfCards]] = arrayOfThreeCards[0]
        gameDictionary[setButtons[currentAmountOfCards + 1]] = arrayOfThreeCards[1]
        gameDictionary[setButtons[currentAmountOfCards + 2]] = arrayOfThreeCards[2]
        setButtons[currentAmountOfCards].layer.addSublayer(gradientLayer1)
        setButtons[currentAmountOfCards + 1].layer.addSublayer(gradientLayer2)
        setButtons[currentAmountOfCards + 2].layer.addSublayer(gradientLayer3)
        updateViewFromModel()
        //when this button is pressed either add 3 cards to board, or replace three matching cards 
    }
    
    func intialGameSetup() {
        //initialize buttons
        var indexOfButtons: Int = 0
        for card in game.cards {
            gameDictionary[setButtons[indexOfButtons]] = card
            indexOfButtons += 1
        }
        
        //set up background
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.frame = gradientView.bounds
        let darkGreen = UIColor(red: 0.0/255.0, green: 100.0/255.0, blue: 0/255.0, alpha: 1.0)
        let lightGreen = UIColor(red: 124/255.0, green: 205/255.0, blue: 124/255.0, alpha: 1.0)
        backgroundGradient.colors = [darkGreen.cgColor, lightGreen.cgColor]
        view.layer.insertSublayer(backgroundGradient, at: 0)
        view.sendSubviewToBack(gradientView)
        
        //set up buttons
        dealMoreCardsButton.backgroundColor = .clear
        let color1 = UIColor(red: 139 / 255, green: 69 / 255, blue: 19 / 255, alpha: 1)
        let color2 = UIColor(red: 128 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.cornerRadius = 10.0
        gradient.shadowOpacity = 0.5
        gradient.shadowRadius = 10.0
        gradient.frame = dealMoreCardsButton.bounds
        dealMoreCardsButton.layer.addSublayer(gradient)
        dealMoreCardsButton.setTitle("Deal 3 More Cards", for: .normal)
        
        //Set all cards invisible
        for button in setButtons {
            button.backgroundColor = .clear
        }
        
        //only need to set up 12 REAL buttons
        for index in 0...11 {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.white.cgColor,UIColor.white.cgColor]
            gradientLayer.cornerRadius = 10
            gradientLayer.shadowOpacity = 0.2
            gradientLayer.shadowRadius = 10
            gradientLayer.frame = setButtons[index].bounds
            setButtons[index].backgroundColor = .clear
            setButtons[index].layer.addSublayer(gradientLayer)
        }
    }
    
    @IBAction func newGame(_ sender: Any) {
        numberOfCardsTouched = 0
        game.score = 0
        numberOfDeals = 0
        gameDictionary.removeAll()
        game.cards = []
        usedCards = []
        self.game = Set()
        self.intialGameSetup()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        scoreLabel.text = "Score: \(game.score)"
        
        for buttonCards in gameDictionary {
            let button = buttonCards.key
            let correspondingCard = buttonCards.value
                  converter(card: correspondingCard, button: button)
        }
    }
    
    
    
    
    func converter(card: Card, button: UIButton) {
        
        let shape: String
        
        switch card.cardShape {
        case 1:
            shape = "▲"
            break
        case 2:
            shape = "■"
            break
        case 3:
            shape = "●"
            break
        default:
            shape = ""
            break
        }
        
        let attributedQuote = NSMutableAttributedString(string: shape)
        let fontAndSizeAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        attributedQuote.addAttributes(fontAndSizeAttribute, range: NSRange(location: 0, length: 1))
        
        var green = false
        var blue = false
        var red = false
        
        switch card.cardColour {
        case 1:
            let attribute: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor : UIColor.red
            ]
            attributedQuote.addAttributes(attribute, range: NSRange(location: 0, length: 1))
            red = true
            break
        case 2:
            let attribute: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor : UIColor.green
            ]
            attributedQuote.addAttributes(attribute, range: NSRange(location: 0, length: 1))
            green = true
            break
        case 3:
            let attribute: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor : UIColor.blue
            ]
            attributedQuote.addAttributes(attribute, range: NSRange(location: 0, length: 1))
            blue = true
            break
        default:
            break
        }
        
        switch card.cardFillType {
        case 1:
            //filled in
            let attribute = [NSAttributedString.Key.strokeWidth: -3.0]
            attributedQuote.addAttributes(attribute, range: NSRange(location: 0, length: 1))
            break
        case 2:
            //hollow
            let attribute = [NSAttributedString.Key.strokeWidth: 3]
            attributedQuote.addAttributes(attribute, range: NSRange(location: 0, length: 1))
            break
        case 3:
            let attribute: [NSAttributedString.Key: Any]?
            if (red) {
                attribute = [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0, blue: 0, alpha: 0.5) ]
            } else if (blue) {
                attribute = [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 1, alpha: 0.5) ]
            } else if (green) {
                attribute = [NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 1, blue: 0, alpha: 0.5) ]
            } else {
                attribute = nil
            }
            attributedQuote.addAttributes(attribute!, range: NSRange(location: 0, length: 1))
            break
        default:
            break
        }
        
        switch card.cardNumberOfElement {
        case 1:
            break
        case 2:
            attributedQuote.append(attributedQuote)
            break
        case 3:
            attributedQuote.append(attributedQuote)
            attributedQuote.append(attributedQuote)
            attributedQuote.deleteCharacters(in: NSRange(location: 0, length: 1))
            break
        default:
            break
        }
        
        button.setAttributedTitle(attributedQuote, for: .normal)
    }
    
}


