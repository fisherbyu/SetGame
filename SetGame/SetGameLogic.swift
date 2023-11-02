//
//  SetGameEngine.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import Foundation
import SwiftUI
enum CardShape: CaseIterable {
    case oval, diamond, squiggle
}

enum CardColor: CaseIterable {
    case red, green, purple
}

enum NumberOfShapes: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

enum Shade: CaseIterable {
    case solid, striped, open
}

struct CardFace: Equatable {
    let shape: CardShape
    let color: CardColor
    let numberOfShapes: NumberOfShapes
    let shade: Shade
}

var Deck: [CardFace] {
    var cards: [CardFace] = []
    for shape in CardShape.allCases {
        for color in CardColor.allCases {
            for number in NumberOfShapes.allCases {
                for shade in Shade.allCases {
                    let face = CardFace(shape: shape, color: color, numberOfShapes: number, shade: shade)
                    cards.append(face)
                }
            }
        }
    }
    return cards
}

// Game Engine
struct SetGameLogic {
    // MARK: --Properties
    var deck: Array<Card>
    var cards: Array<Card>
    var initialCardsToDeal = 12
    var numCardsToDeal = 3
    var selectedIndexes: Array<Int>
            
    // MARK: --Initializer
    init() {
        // Build Deck, Shuffle
        deck = []
        var index = 0
        for face in Deck {
            let card = Card(id: index, shape: face.shape, numberOfShapes: face.numberOfShapes, color: face.color, shade: face.shade)
            deck.append(card)
            index += 1
        }
        deck.shuffle()
        
        // Build Card Selection Arrays
        selectedIndexes = []
        cards = []
    }
    
    // MARK: --Game Logic
    func IsSetCandidate<E: Equatable>(_ c1: E, _ c2: E, _ c3: E) -> Bool {
        c1 == c2 && c2 == c3 ||
        c1 != c2 && c2 != c3 && c1 != c3
    }
    func isSet() -> Bool {
        guard selectedIndexes.count == 3 else {
            return false // A Set always has three cards
        }
        
        let c1 = cards[selectedIndexes[0]]
        let c2 = cards[selectedIndexes[1]]
        let c3 = cards[selectedIndexes[2]]
        
        return IsSetCandidate(c1.shape, c2.shape, c3.shape)
        && IsSetCandidate(c1.color, c2.color, c3.color)
        && IsSetCandidate(c1.numberOfShapes, c2.numberOfShapes, c3.numberOfShapes)
        && IsSetCandidate(c1.shade, c2.shade, c3.shade)
    }
    
    mutating func dealOneCard() {
        if deck.count > 0 {
            let cardToDeal = deck.remove(at: 0)
            cards.append(cardToDeal)
        }
    }
    
    mutating func removeOneCard(index: Int) {
        cards.remove(at: index)
    }
    
    mutating func replaceOneCard(index: Int) {
        if deck.count > 0 {
            let cardToDeal = deck.remove(at: 0)
            cards[index] = cardToDeal
        } else {
            cards.remove(at: index)
        }
    }
    
    mutating func updateSelect(index: Int) {
        // Toggle Selection Attribute
        cards[index].isSelected.toggle()
        
        // Toggle Presence of Index in selectedIndexes
        if let targetIndex = selectedIndexes.enumerated().first(where: { $0.element == index })?.offset {
            selectedIndexes.remove(at: targetIndex)
        } else {
            selectedIndexes.append(index)
        }
    }
    
    mutating func matchCards() {
        if isSet() {
            for i in selectedIndexes {
                cards[i].isMatched = true
            }
        }
    }
    
    mutating func resetSelection() {
        for i in selectedIndexes {
            cards[i].isSelected.toggle()
        }
        selectedIndexes = []
    }
    
    // MARK: -- Components
    struct Card: Identifiable {
        var id: Int
        var shape: CardShape
        var numberOfShapes: NumberOfShapes
        var color: CardColor
        var shade: Shade
        var isMatched = false
        var isSelected = false
    }
}
