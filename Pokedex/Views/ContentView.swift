//
//  ContentView.swift
//  Pokedex
//
//  Created by Vu Trinh on 9/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: PokemonModel // Model that manages all methods
    @State var chosenPokemon: String? // Variable to keep track which pokemon the user taps on
    @State var countPokemon: Int = 0 // Count the number of fetched pokemons
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 15) {
                    if (chosenPokemon != nil) {
                        ZStack { // Add styling
                            Rectangle()
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray, Color.white]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                .frame(height: 150)
                            PokemonImageView(url: chosenPokemon!)
                        }
                        .id("top")
                    }
                    
                    LazyVGrid(columns: columns) { // Display the pokemons in grid
                        ForEach(model.pokemonImages, id: \.self) { url in
                            Button {
                                chosenPokemon = url
                            } label: {// Check image cache, if it exists, use that
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5.0)
                                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                        .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.mint, Color.green]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                        .frame(minHeight: 100, maxHeight: 120)
                                    
                                    PokemonImageView(url: url)
                                }
                                .onAppear {
                                    if (CacheService.getImage(forKey: url) == nil) { // Only count when the pokemon appears for the first time
                                        countPokemon += 1
                                    }
                                    if (countPokemon % 20 == 0) { // Fetch new pokemons when we reach the 20th pokemon of the last fetch
                                        if let nextUrl = model.nextUrlLink {
                                            model.fetchData(url: nextUrl, type: .pokemonList)
                                        }
                                    }
                                }
                                .shadow(radius: 8)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .onAppear { // Fetch the first 20 pokemons
                    model.fetchData(url: Constants.BASE_API_URL, type: .pokemonList)
                }
            }
            .onChange(of: chosenPokemon) { _ in
                withAnimation { // When use tap on a pokemon, we scroll to the top to show the pokemon in the large card
                    proxy.scrollTo("top")
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PokemonModel())
    }
}
