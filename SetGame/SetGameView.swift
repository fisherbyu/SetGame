//
//  ContentView.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import SwiftUI


struct SetGameView: View {
    // Define Game
    let setgame: SetGame
    var body: some View {
        // Define Layout, allow for resizing
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
                // Game Controls
                HStack {
                    Spacer()
                    // Only add three is there are cards to deal
                    if setgame.countDealtCards() < 81 {
                        Button("Deal 3") {
                            setgame.dealMoreCards()
                        }
                        Spacer()
                    }
                    Button("New Game") {
                        setgame.newGame()
                    }
                    Spacer()
                    
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
