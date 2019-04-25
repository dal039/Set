//
//  Deck.swift
//  Set
//
//  Created by David Lee on 8/4/18.
//  Copyright © 2018 David Lee. All rights reserved.
//

import Foundation

struct Deck
{
    private(set) var cards = [Card]()
    
    // Builds shuffled deck
    init () {
        for color in Card.Feature.Property.all {
            for shape in Card.Feature.Property.all {
                for number in Card.Feature.Property.all {
                    for symbol in Card.Feature.Property.all {
                        cards.append(Card(color: color, shape: shape, number: number, symbol: symbol))
                    }
                }
            }
        }
        
        cards = shuffle(this: cards)
        // REMOVE: checking if deck of 81 cards is created
//        print(cards)
    }
    
    // Draw a card from top of deck, removes that card from deck
    mutating func drawCard() -> Card
    {
        return cards.removeFirst()
    }
    
    // Shuffle a deck of cards
    func shuffle(this thing: [Card]) -> [Card]
    {
        var shuffledDeck = [Card]()
        var deck = thing
        
        while deck.count > 0
        {
            let randomIndex = Int(arc4random_uniform(UInt32(deck.count)))
            shuffledDeck.append(deck[randomIndex])
            deck.remove(at: randomIndex)
        }
        
        return shuffledDeck
    }
}
