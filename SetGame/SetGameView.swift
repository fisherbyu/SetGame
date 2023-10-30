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
                LazyVGrid(columns: getNumColoumns(size: geometry.size)) {
                    ForEach(setgame.dealtCards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                setgame.selectCard(card: card)
                            }
                        .aspectRatio(2/3, contentMode: .fill)
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
    
    private func getNumColoumns(size: CGSize) -> [GridItem] {
        var columns = 3
        let numCards = setgame.countDealtCards()
        let spacing: CGFloat = 0.5
        var spacingWidth: CGFloat = CGFloat(columns - 1) * spacing
        var proposedCardWidth: CGFloat = (size.width - spacingWidth) / CGFloat(columns)
        var rows = (numCards + columns - 1) / columns

        let aspectRatio: CGFloat = 2/3
        var requiredHeight = (proposedCardWidth * aspectRatio + spacing) * CGFloat(rows)

        while requiredHeight > size.height {
            columns += 1
            spacingWidth = CGFloat(columns - 1) * spacing
            proposedCardWidth = (size.width - spacingWidth) / CGFloat(columns)
            rows = (numCards + columns - 1) / columns
            requiredHeight = (proposedCardWidth * aspectRatio + spacing) * CGFloat(rows)
        }
        return Array(repeating: GridItem(), count: columns)
    }
    
    private func randomOffscreenLocation() -> CGSize {
        let angle = Double.random(in: 0...359)
        let radius = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 2
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGSize(width: x, height: y)
    }
}

#Preview {
    SetGameView(setgame: SetGame())
}
