//
//  ViewController.swift
//  Concentration
//
//  Created by Bhasin on 09/12/17.
//  Copyright © 2017 Bhasin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: noOfPairOfCards)
    
    var noOfPairOfCards : Int {
        return (cardButtons.count+1)/2
    }
    
    /*private(set) var flipCount = 0 {
     didSet {
     flipCountLabel.text = "Flips: \(flipCount)"
     }
     }*/
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction private func touchCard(_ sender: UIButton) {
        //flipCount += 1
        
        if let cardNumber = cardButtons.index(of: sender){
            // check card in model and update status  for isFaceUp and isMatched
            game.chooseCard(at: cardNumber)
            // update view from model once the status has been updated in model
            updateViewFromModel()
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game.newGame()
        updateViewFromModel()
    }
    private func updateViewFromModel(){
        // check for status for each card in model and update view.
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for:UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                button.setTitle("", for:UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0) : #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            }
        }
        //update score
        scoreLabel.text = "Score:\(game.score)"
    }
    
    private var emoojiChoices = ["😈","👽","🤖","👻","🎃","🦇","🐵"]
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String{
        
        if emoji[card] == nil, emoojiChoices.count > 0 {
            let randomIndex =  Int( arc4random_uniform(UInt32(emoojiChoices.count)))
            emoji[card] = emoojiChoices.remove(at: randomIndex)
            
        }
        return emoji[card] ?? "?"
        
    }
} 
