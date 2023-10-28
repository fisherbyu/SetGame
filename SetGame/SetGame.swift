//
//  SetGame.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import Foundation

//var validSet = [SetGameLogic.Card(id: 1, shape: .oval, numberOfShapes: .one, color: .red, shade: .open),
//                SetGameLogic.Card(id: 2, shape: .oval, numberOfShapes: .two, color: .red, shade: .open),
//                SetGameLogic.Card(id: 3, shape: .oval, numberOfShapes: .three, color: .red, shade: .open)
//]


@Observable class SetGame {
    // MARK: - Properties
    private var game = SetGameLogic()
    var numCardsDealt = 3
    // MARK: - Model Access
    private var cards: Array<SetGameLogic.Card> {
        game.cards
    }
    var dealtCards: Array<SetGameLogic.Card> {
        return Array(cards.prefix(numCardsDealt))
    }

    // MARK: - User Intents
    func dealMoreCards() {
        numCardsDealt += 3
    }
    func newGame() {
        print("NEW GAME HERE")
    }
    func selectCard(card: SetGameLogic.Card) {
        game.selectCard(card: card)
    }

    
}