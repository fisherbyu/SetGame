//
//  SetGame.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import Foundation

@Observable class SetGame {
    // MARK: - Properties
    private var game = SetGameLogic()
    // MARK: - Model Access
    var dealtCards: Array<SetGameLogic.Card> {
        return Array(game.cards.prefix(game.numCardsDealt))
    }

    // MARK: - User Intents
    func dealMoreCards() {
        game.dealMoreCards()
    }
    func newGame() {
        print("NEW GAME HERE")
    }
    func selectCard(card: SetGameLogic.Card) {
        game.selectCard(card: card)
    }    
}
