//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vu Trinh on 9/11/22.
//

import Foundation

// The struct presents each object in results list of PokemonList
struct PokemonLink: Decodable {
    let name: String
    let url: String
}

// The struct presents the response from each API call with offset and limit queries
struct PokemonList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonLink]
}

// The struct presents the data of each pokemon
struct Pokemon: Decodable {
    var front_default = ""
    
    enum CodingKeys: String, CodingKey {
        case sprites
        case front_default
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        
        // Parse front_default
        self.front_default = try spritesContainer.decode(String.self, forKey: .front_default)
    }
}
