//
//  ContentView.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import SwiftUI
//var validSet = [SetGameLogic.Card(id: 1, shape: .oval, numberOfShapes: .one, color: .red, shade: .open),
//                SetGameLogic.Card(id: 2, shape: .oval, numberOfShapes: .two, color: .red, shade: .open),
//                SetGameLogic.Card(id: 3, shape: .oval, numberOfShapes: .three, color: .red, shade: .open)
//]


struct SetGameView: View {
    let setgame: SetGame
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LazyVGrid(columns: columns(numCards: setgame.dealtCards.count, for: geometry.size)) {
                    ForEach(setgame.dealtCards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                setgame.selectCard(card: card)
                            }
                    }
                }
                Spacer()
                HStack {
                    if setgame.dealtCards.count < 81 {
                        Button("Deal 3") {
                            setgame.dealMoreCards()
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func columns(numCards: Int, for size: CGSize) -> [GridItem] {
        var desiredCardWidth: Double {
            if numCards < 22 {
                return 125
            }
            else if numCards < 28 {
                return 93
            } else {
                return 62
            }
            
        }
        return Array(
            repeating: GridItem(.flexible()),
            count: Int(size.width / desiredCardWidth)
        )
    }
}

#Preview {
    SetGameView(setgame: SetGame())
}
