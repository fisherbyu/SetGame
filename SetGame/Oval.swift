//
//  Oval.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<3) { _ in
                ZStack {
                    Oval()
                        .opacity(0.25)
                    Oval().stroke(lineWidth: 8)
                }
                .aspectRatio(1/2, contentMode: .fit)
            }
            .rotationEffect(Angle(degrees: 180))
        }
        .foregroundStyle(.purple)
        .padding()
    }
}

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addEllipse(in: rect)
        
        return path
    }
}

#Preview {
    ContentView()
}
