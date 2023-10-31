//
//  StripedBackground.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/29/23.
//

import SwiftUI

struct StripedBackground: View {
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            let numStrips = Int(availableWidth / (Styles.width + Styles.space))
            
            HStack(spacing: 0) {
                ForEach(Array(0..<numStrips), id: \.self) {_ in
                    Color.clear
                    color.frame(width: Styles.width)
                    Color.clear
                }
            }
        }
    }
    
    private struct Styles {
        static let width: CGFloat = 1
        static let space: CGFloat = 2
    }
}

#Preview {
    StripedBackground(color: .green)
}
