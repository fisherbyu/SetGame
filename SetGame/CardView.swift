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
                        ForEach(content.shapes, id: \.self) { shape in
                            Text(shape)
                        }
                    }
                    Text("\(content.shade)")
                }
            }
            .foregroundStyle(content.color)
        }
        .aspectRatio(Card.aspectRatio, contentMode: .fit)
    }
    
    
    
    // MARK: -- Display Values
    private struct Card {
        static let aspectRatio: Double = 2.5/2
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
        var shapes: Array<String> {
            switch card.shape {
            case .diamond:
                return Array(repeating: "<>", count: card.numberOfShapes.rawValue)
            case .oval:
                return Array(repeating: "oo", count: card.numberOfShapes.rawValue)
            case .squiggle:
                return Array(repeating: "~~", count: card.numberOfShapes.rawValue)
            }
        }
        var shade: String {
            switch card.shade {
            case .open:
                return "open"
            case .solid:
                return "solid"
            case .striped:
                return "striped"
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
    
    private func systemFont(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * Card.fontScaleFactor)
    }
}

let testCard = SetGameLogic.Card(
    id: 1,
    shape: .oval,
    numberOfShapes: .three,
    color: .green,
    shade: .solid
)

#Preview {
    CardView(card: testCard)
        .padding(50)
}
