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
//        HStack(spacing: 0) {
//            ForEach(0..<Styles.numStrips, id: \.self) { number in
//                Color.clear
//                color.frame(width: Styles.width)
//                if number == Styles.numStrips - 1 {
//                    Color.clear
//                }
//            }
//        }
        HStack(spacing:0) {
            ForEach(0..<12) {number in
                Color.clear
                color.frame(width: Styles.width)
            }
        }
    }
    
    private struct Styles {
        static let width: CGFloat = 1
        static let numStrips = 3
    }
}

#Preview {
    StripedBackground(color: .green)
}
