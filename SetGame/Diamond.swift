//
//  Diamond.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/28/23.
//

import SwiftUI

struct DiamondView: View {
    var numShapes: Int
    var shade: Shade
    var body: some View {
        HStack {
            ForEach(0..<3) { _ in
                ZStack {
                    if shade == .solid {
                        Diamond()
                            .opacity(0.25)
                        Diamond().stroke(lineWidth: 8)
                    } else if shade == .open {
                        Diamond().stroke(lineWidth: 8)
                    }
                }
                .aspectRatio(1/2, contentMode: .fit)
            }
            .rotationEffect(Angle(degrees: 180))
        }
        .foregroundStyle(.purple)
        .padding()
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    DiamondView(numShapes: 3, shade: .solid)
}
