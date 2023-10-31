//
//  Oval.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/28/23.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct OvalPreview: View {
    var body: some View {
        Oval()
            .fill(Color.blue)
            .padding(50)
    }
}

#Preview {
    OvalPreview()
}
