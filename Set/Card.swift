//
//  Card.swift
//  Set
//
//  Created by David Lee on 8/4/18.
//  Copyright © 2018 David Lee. All rights reserved.
//

import Foundation

struct Card
{
    // Each card has features with a unique combination of properties
    let color: Feature.Property
    let shape: Feature.Property
    let number: Feature.Property
    let symbol: Feature.Property
    
    // A card has 4 features and each feature with 3 properties
    enum Feature
    {
        case color(Property)
        case shape(Property)
        case number(Property)
        case symbol(Property)
        
        enum Property
        {
            case A
            case B
            case C
            
            static let all = [Property.A, Property.B, Property.C]
        }
    }
}

extension Card: Equatable
{
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.color == rhs.color) &&
            (lhs.shape == rhs.shape) &&
            (lhs.number == rhs.number) &&
            (lhs.symbol == rhs.symbol)
    }
}

