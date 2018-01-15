//
//  Card.swift
//  Concentration
//
//  Created by Bhasin on 10/12/17.
//  Copyright © 2017 Bhasin. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var faceupOnce = false
    private var identifier: Int
    
    private static var indentifierFactory = 0
    
    private static func getUniqueIdentifier()->Int {
        indentifierFactory += 1
        return indentifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
