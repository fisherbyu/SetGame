//
//  SetGame.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import Foundation
import SwiftUI

@Observable class SetGame {
    // MARK: - Properties
    private var game = SetGameLogic()
    
    // MARK: - + Model Access
    var dealtCards: Array<SetGameLogic.Card> {
        return Array(game.cards)
    }

    // MARK: - User Intents
    func dealCards() {
        for i in 0..<game.initialCardsToDeal {
            let delay = Double(i) * Constants.delayFactor
            withAnimation(.easeInOut.delay(delay)) {
                game.dealOneCard()
            }
        }
    }
    
    func dealMoreCards() {
        if game.isSet() {
            removeMatchedCards()
        } else {
            for i in 0..<game.numCardsToDeal {
                let delay = Double(i) * Constants.delayFactor
                withAnimation(.easeInOut.delay(delay)) {
                    game.dealOneCard()
                }
            }
        }
    }
    
    func selectCard(card: SetGameLogic.Card) {
        // Locate Card in Deck
        if let targetIndex = dealtCards.firstIndex(matching: card) {
            if game.selectedIndexes.count < 3 {
                game.updateSelect(index: targetIndex)
                if game.selectedIndexes.count == 3 {
                    game.matchCards()
                }
            } else if game.selectedIndexes.count == 3 {
                if game.isSet() {
                    // Remove matched cards then add to selected indexes
                    removeMatchedCards()
                    if let newTarget = dealtCards.firstIndex(matching: card) {
                        game.updateSelect(index: newTarget)
                    }
                } else {
                    // Remove from queue if allready there
                    if game.selectedIndexes.firstIndex(matching: targetIndex) != nil {
                        game.updateSelect(index: targetIndex)
                    } else {
                        // New Selection
                        game.resetSelection()
                        game.updateSelect(index: targetIndex)
                    }
                }
            }
        }
    }

    
//    func removeOneCard(index: Int) {
//        let delay = Constants.delayFactor
//        withAnimation(.easeInOut.delay(delay)) {
//            game.removeOneCard(index:index)
//        }
//    }
    
    func removeMatchedCards() {
        game.selectedIndexes.sort() { $0 > $1 }
        for i in game.selectedIndexes {
            let delay = Double(i) * Constants.delayFactor
            withAnimation(.easeInOut.delay(delay)) {
                game.replaceOneCard(index: i)
            }
        }
        game.selectedIndexes = []
    }
    func newGame() {
        game = SetGameLogic()
//        dealtCards = []
        dealCards()
    }
    
    
    
//    func selectCard(card: SetGameLogic.Card) {
//        game.selectCard(card: card)
//    }   
    
    func countDealtCards() -> Int {
        return game.cards.count
    }
    
    struct Constants {
        static let delayFactor = 0.1
    }
}


