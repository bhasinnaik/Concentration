 //
 //  Concentration.swift
 //  Concentration
 //
 //  Created by Bhasin on 10/12/17.
 //  Copyright © 2017 Bhasin. All rights reserved.
 //
 
 import Foundation
 
 class Concentration{
    private(set) var cards = [Card]()
    private(set) var score : Int
    
    
    // Computed property to check whether one and only one card isFaceUp to check match condition.
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex  == nil{
                        foundIndex = index
                    }else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
                
            }
        }
    }
    
    func newGame(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards.shuffle()
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard(at : \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched{
            // match condition is executed when only two cards are faceUp
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards matched
                if cards[matchIndex]  == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
                
            }else {
                //either no cards or two cards face up
                indexOfOneAndOnlyFaceUpCard = index
                // check if card is already faced up once then score = -1.
                if cards[index].faceupOnce == true{
                    score -= 1
                }else{
                    cards[index].faceupOnce = true
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        // todo shuffle the cards
        cards.shuffle()
        score = 0
    }
 }
 
 extension Array {
    mutating func shuffle(){
        if count < 2 {
            return
        }
        /*for index in self.indices {
            let diff = distance(from: index, to: endIndex)
            let newIndex =  Int( arc4random_uniform(UInt32(diff)))
            (self[index],self[newIndex]) = (self[newIndex],self[index])
            
        }*/
        for _ in self.indices{
            sort{(_,_) in arc4random() < arc4random() }
        }
    }
 }
 
