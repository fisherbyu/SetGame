//
//  Diamond.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/28/23.
//

import SwiftUI


struct Diamond: Shape {

    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let firstPoint = CGPoint(x: rect.midX, y: rect.minY)
        let secondPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let end = CGPoint(x: rect.midX, y: rect.maxY)
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: firstPoint)
        p.addLine(to: secondPoint)
        p.addLine(to: end)
        p.addLine(to: start)
        p.addLine(to: firstPoint)
        
        return p
    }
}

struct DiamondPreview: View {
    var body: some View {
        Diamond()
            .fill(Color.blue)
            .padding(50)
    }
}

#Preview {
    DiamondPreview()
}
