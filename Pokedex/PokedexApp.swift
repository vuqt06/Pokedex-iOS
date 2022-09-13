//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Vu Trinh on 9/11/22.
//

import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView().environmentObject(PokemonModel())
        }
    }
}
