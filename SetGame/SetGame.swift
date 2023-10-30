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
    var dealtCards: Array<SetGameLogic.Card>
    
    init() {
        dealtCards = []
    }
    
    // MARK: - Model Access
//    var dealtCards: Array<SetGameLogic.Card> {
//        return Array(game.cards)
//    }

    // MARK: - User Intents
    func dealMoreCards() {
        game.dealMoreCards()
    }
    
    func newGame() {
        game = SetGameLogic()
    }
    
    func selectCard(card: SetGameLogic.Card) {
        game.selectCard(card: card)
    }   
    
    func countDealtCards() -> Int {
        return game.cards.count
    }
}
