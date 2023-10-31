//
//  CardView.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import SwiftUI

struct CardView: View {
    let card: SetGameLogic.Card
    private var content: Content {
        Content(card: card)
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: Card.cornerRadius).fill(
                    content.selectionColor
                )
                RoundedRectangle(cornerRadius: Card.cornerRadius).stroke()
                VStack {
                    HStack {
                        ShapeView(card: card, color: content.color, size: geometry.size)
                            
                    }
                    .frame(width: geometry.size.width * 0.99, height: geometry.size.height * 0.9)
                }
            }
//            .aspectRatio(Card.aspectRatio, contentMode: .fit)
            .foregroundStyle(content.color)
        }
        .aspectRatio(Card.aspectRatio, contentMode: .fit)
    }
    
    // MARK: -- Display Values
    private struct Card {
        static let aspectRatio: Double = 3/2
        static let cornerRadius: Double = 10.0
        static let fontScaleFactor = 0.75
    }
    private struct Content {
        var card: SetGameLogic.Card
        var color: Color {
            switch card.color {
            case .red:
                return .red
            case .green:
                return .green
            case .purple:
                return .purple
            }
        }
        var selectionColor: Color {
            if !card.isSelected {
                return .white
            } else {
                if card.isMatched {
                    return .green.opacity(1/10)
                } else {
                    return .blue.opacity(1/10)
                }
            }
        }
        
    }
}

let testCard = SetGameLogic.Card(
    id: 1,
    shape: .squiggle,
    numberOfShapes: .three,
    color: .green,
    shade: .striped
)

#Preview {
    CardView(card: testCard)
        .padding(50)
}
