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
    
//    func calculateNumberOfColumns(size: CGSize, cardCount: Int) -> [GridItem] {
//        var columns = 2 // Minimum number of columns
//        var spacing: CGFloat = 1
//        var spacingWidth: CGFloat = CGFloat(columns - 1) * spacing
//        var proposedCardWidth: CGFloat = (size.width - spacingWidth) / CGFloat(columns)
//        var rows = (cardCount + columns - 1) / columns
//
//        // Calculate the height required for rows of the proposed card width
//        let aspectRatio: CGFloat = 1.5 // Change this to your card's aspect ratio
//        var requiredHeight = (proposedCardWidth * aspectRatio + spacing) * CGFloat(rows)
//
//        // Continue adding columns until the required height fits within the available size
//        while requiredHeight > size.height {
//            columns += 1
//            spacingWidth = CGFloat(columns - 1) * spacing
//            proposedCardWidth = (size.width - spacingWidth) / CGFloat(columns)
//            rows = (cardCount + columns - 1) / columns
//            requiredHeight = (proposedCardWidth * aspectRatio + spacing) * CGFloat(rows)
//        }
//
//        return Array(repeating: GridItem(), count: columns)
//    }

    
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
