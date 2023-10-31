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
    var dealtCards: Array<SetGameLogic.Card>
    
    init() {
        dealtCards = []
    }
    
    // MARK: - Model Access
//    var dealtCards: Array<SetGameLogic.Card> {
//        return Array(game.cards)
//    }
    func dealCards() {
        for i in 0..<3 {
            let delay = Double(i) * Constants.delayFactor
            withAnimation(.easeInOut.delay(delay)) {
                dealtCards.append(game.cards[i])
            }
        }
    }

    // MARK: - User Intents
    func dealMoreCards() {
        game.dealMoreCards()
    }
    
    func newGame() {
        game = SetGameLogic()
        dealtCards = []
        dealCards()
    }
    
    func selectCard(card: SetGameLogic.Card) {
        game.selectCard(card: card)
    }   
    
    func countDealtCards() -> Int {
        return game.cards.count
    }
    
    struct Constants {
        static let delayFactor = 0.15
    }
}
