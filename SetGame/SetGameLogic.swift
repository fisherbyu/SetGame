//
//  SetGameEngine.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import Foundation
import SwiftUI
enum Shape: CaseIterable {
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
    let shape: Shape
    let color: CardColor
    let numberOfShapes: NumberOfShapes
    let shade: Shade
}
var Deck: [CardFace] {
    var cards: [CardFace] = []
    for shape in Shape.allCases {
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


struct SetGameLogic {
    // MARK: --Properties
    var cards: Array<Card>
    var selectedIndexes: Array<Int>
    // MARK: --Initializer
    init() {
        // Build Cards Array
        cards = []
        var i = 0
        for face in Deck {
            let card = Card(id: i, shape: face.shape, numberOfShapes: face.numberOfShapes, color: face.color, shade: face.shade)
            cards.append(card)
            i += 1
        }
        cards.shuffle()
        // Buil Array of Selected Indexes
        selectedIndexes = []
    }
    // MARK: --Game Logic
    func isSet(indexes: [Int]) -> Bool {
        guard indexes.count == 3 else {
            return false // A Set always has three cards
        }
        let card1 = cards[indexes[0]]
        let card2 = cards[indexes[1]]
        let card3 = cards[indexes[2]]
        let shapeMatch = (card1.shape == card2.shape && card2.shape == card3.shape) || (card1.shape != card2.shape && card2.shape != card3.shape && card1.shape != card3.shape)
        let quantityMatch = (card1.numberOfShapes == card2.numberOfShapes && card2.numberOfShapes == card3.numberOfShapes) || (card1.numberOfShapes != card2.numberOfShapes && card2.numberOfShapes != card3.numberOfShapes && card1.numberOfShapes != card3.numberOfShapes)
        let colorMatch = (card1.color == card2.color && card2.color == card3.color) || (card1.color != card2.color && card2.color != card3.color && card1.color != card3.color)
        let shadeMatch = (card1.shade == card2.shade && card2.shade == card3.shade) || (card1.shade != card2.shade && card2.shade != card3.shade && card1.shade != card3.shade)

        return shapeMatch && quantityMatch && colorMatch && shadeMatch
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
    
    mutating func matchCard(indexes: [Int]) {
        if isSet(indexes: indexes) {
            for i in indexes {
                cards[i].isMatched = true
            }
        }
    }
    
    mutating func removeMatchedCards() {
        selectedIndexes.sort()
        cards.remove(at: selectedIndexes[2])
        cards.remove(at: selectedIndexes[1])
        cards.remove(at: selectedIndexes[0])
        selectedIndexes = []
    }
    
    mutating func selectCard(card: Card) {
        
        // Locate Card in Deck
        if let targetIndex = cards.firstIndex(matching: card) {
            if selectedIndexes.count < 3 {
                updateSelect(index: targetIndex)
                if selectedIndexes.count == 3 {
                    matchCard(indexes: selectedIndexes)
                }
            } else if selectedIndexes.count == 3 {
                if isSet(indexes: selectedIndexes) {
                    // Remove matched cards then add to selected indexes
                    removeMatchedCards()
                    updateSelect(index: targetIndex)
                } else {
                    // Remove from queue if allready there
                    if selectedIndexes.firstIndex(matching: targetIndex) != nil {
                        updateSelect(index: targetIndex)
                    }
                }
            }
        }
    }

    // Define Card Model
    struct Card: Identifiable {
        var id: Int
        var shape: Shape
        var numberOfShapes: NumberOfShapes
        var color: CardColor
        var shade: Shade
//        var shapes: [Shape] {
//            return Array(repeating: shape, count: numberOfShapes.rawValue)
//        }
//        var isFaceUp = true
        var isMatched = false
        var isSelected = false
    }
}



