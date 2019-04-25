//
//  Set.swift
//  Set
//
//  Created by David Lee on 8/4/18.
//  Copyright © 2018 David Lee. All rights reserved.
//

import Foundation

// Models a game of Set
class GameSet
{
    // Deck you draw from
    private(set) var deck = Deck()
    
    // Cards in play for creating sets, min of 12, max of 24
    private(set) var cardsInPlay = [Card]()
    
    // Cards that are selected, max of 3
    private(set) var selectedCards = [Card]()
    
    // Game score
    private(set) var score = 0;
    
    var tempDeck = [Card]()
    var removedCards = [Card]()
    
    init() {
        dealTwelve()
        tempDeck = cardsInPlay
        checkDeckCount(of: tempDeck, of: deck.cards)
        print(cardsInPlay.count, deck.cards.count)
    }
    
    // Select a card adds to array of selected cards
    func selectCard(_ index: Int)
    {
        print("Selected Before: \(selectedCards.count)")
        print("In Play: \(cardsInPlay.count)")
        let currentCard = cardsInPlay[index]
        if selectedCards.count < 3 && selectedCards.contains(currentCard){
            selectedCards.remove(at: selectedCards.index(of: currentCard)!)
        } else if selectedCards.count >= 0 {
            selectedCards.append(cardsInPlay[index])
        }
        print("Selected After \(selectedCards.count)")

    }
    
    // Checks if selected 3 cards are a set
    func checkIfSet() -> Bool
    {
        let colorCount = Set(selectedCards.map{$0.color}).count
        let shapeCount = Set(selectedCards.map{$0.shape}).count
        let symbolCount = Set(selectedCards.map{$0.symbol}).count
        let numberCount = Set(selectedCards.map{$0.number}).count
        
        if (colorCount != 2) && (shapeCount != 2) &&
            (symbolCount != 2) && (numberCount != 2) {
//            cardsInPlay = cardsInPlay.filter{ !selectedCards.contains($0) }
//            selectedCards.removeAll()
            if deck.cards.count > 0 && deck.cards.count <= 12
            {
                for card in selectedCards
                {
                    let tempCard = deck.drawCard()
                    checkDuplicate(of: tempCard, within: tempDeck)
                    tempDeck.append(tempCard)
                    checkDeckCount(of: tempDeck, of: deck.cards)
                    removedCards.append(card)
                    let index = cardsInPlay.index(of: card)!
                    cardsInPlay[index] = tempCard
                }
            } else {
                cardsInPlay = cardsInPlay.filter{ !selectedCards.contains($0) }
                removedCards.append(contentsOf: selectedCards)
            }
            //print(deck.cards.count)
            var tempCards = cardsInPlay
            for card in cardsInPlay {
                if let tempCardIndex = tempCards.index(of: card) {
                    tempCards.remove(at: tempCardIndex)
                }
                if tempCards.contains(card){
                    print("Duplicate found!")
                }
            }
            for card in removedCards
            {
                if cardsInPlay.contains(card)
                {
                    print("Duplicate in removed cards: \(card)")
                }
            }
            print("Num of cards removed: \(removedCards.count)")
            selectedCards.removeAll()
            print("found match")
//            dealThree()
            return true
        } else {
            selectedCards.removeAll()
            return false
        }
    }
    
    //func updateGameState(after check: Bool, )
    
    // Deal three additional cards
    func dealThree() 
    {
        if deck.cards.count > 0
        {
            for _ in 1...3
            {
                let tempCard = deck.drawCard()
                checkDuplicate(of: tempCard, within: tempDeck)
                tempDeck.append(tempCard)
                checkDeckCount(of: tempDeck, of: deck.cards)
                cardsInPlay.append(tempCard)
            }

        }
    }
    
    // Deal twelve cards for start of game
    func dealTwelve()
    {
        if deck.cards.count > 0
        {
            for _ in 1...12
            {
                cardsInPlay.append(deck.drawCard())
            }
            
        }
        print("Num of cards played at start: \(cardsInPlay.count)")
    }
    
    //Reset Score
    func resetScore()
    {
        score = 0;
    }
    
    //Award 3 to score for matches
    func increaseScore()
    {
        score += 3;
    }
    
    //Decrease score by 5 for mismatch
    func decreaseScore()
    {
        score -= 5
    }
    
    // Debug function
    func checkDuplicate(of card: Card, within deck: [Card])
    {
        //print("Num of cards played: \(deck.count)")
        if deck.contains(card)
        {
            print("Duplicate Found: \(card)")
        }
    }
    
    func checkDeckCount(of deck1: [Card], of deck2: [Card])
    {
        print("Count of tempDeck: \(deck1.count)")
        print("Count of main deck: \(deck2.count)")
    }
}
