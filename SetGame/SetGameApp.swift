//
//  SetGameApp.swift
//  SetGame
//
//  Created by Andrew Fisher on 10/26/23.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(setgame: SetGame())
        }
    }
}
