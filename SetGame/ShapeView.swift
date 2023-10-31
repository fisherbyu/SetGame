//
//  ShapeView.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/29/23.
//

import SwiftUI

struct ShapeView: View {
    var card: SetGameLogic.Card
    var color: Color
    var size: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                switch card.numberOfShapes {
                case .one:
                    shapeBuilder().padding(10)
                case .two:
                    shapeBuilder()
                    shapeBuilder()
                case .three:
                    shapeBuilder()
                    shapeBuilder()
                    shapeBuilder()
                }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .frame(width: geometry.size.width * 0.98, height: geometry.size.height * 0.98)
        }
    }
    
    @ViewBuilder
    private func shapeBuilder() -> some View {
        ZStack {
            // Define Shapes + Borders
            let diamond = Diamond()
            let diamondOutline = Diamond().stroke(color, lineWidth: Styles.lineWidth)
            let oval = Oval()
            let ovalOutline = Oval().stroke(color, lineWidth: Styles.lineWidth)
            let squiggle = Squiggle()
            let squiggleOutline = Squiggle().stroke(color, lineWidth: Styles.lineWidth)
            
            // Select Which Shape to Render
            switch card.shape {
            case .diamond:
                diamondOutline
                shapeFiller().mask(diamond)
            case .oval:
                ovalOutline
                shapeFiller().mask(oval)
            case .squiggle:
                squiggleOutline
                shapeFiller().mask(squiggle)
            }
        
            
        }
//        .frame(maxWidth: width, maxHeight: height)
        .aspectRatio(1/2, contentMode: .fit )
    }
    @ViewBuilder
    private func shapeFiller() -> some View {
        switch card.shade {
        case .open:
            Color.clear
        case .solid:
            color
        case .striped:
            StripedBackground(color: color)
        }
    }
    
    private struct Styles {
        static let lineWidth: CGFloat = 1
        static let reduceWidth: CGFloat = 0.65
        static let reduceHeight: CGFloat = 0.15
    }
}

let testSize = CGSize(width: 3, height: 2)

#Preview {
    ShapeView(card: testCard, color: .green, size: testSize)
}
