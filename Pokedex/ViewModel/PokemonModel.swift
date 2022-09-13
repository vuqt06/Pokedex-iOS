//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Vu Trinh on 9/11/22.
//

import Foundation
import SwiftUI
// Enum class for classifying different types of API call
enum DataType: Int {
    case pokemonList = 0 // API call to fetch a list of pokemons
    case pokemonData = 1 // API call to fetch the data for the single pokemon
}

class PokemonModel: ObservableObject {
    @Published var pokemonImages: [String] = [String]() // Array to hold fetched images
    var nextUrlLink: String? // Variable to keep track of the URL to fetch next
    
    // Method to fetch the data from an URL
    func fetchData(url: String, type: DataType) {
        
        // Create URL
        let urlComponents = URLComponents(string: url)
        
        let url = urlComponents?.url
        
        if let url = url {
            // Create URL Request
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // Create URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                // Check that there is no error
                if error == nil {
                    do {
                        // Parse JSON
                        let decoder = JSONDecoder()
                        if (type == .pokemonList) { // If we fetch the list of pokemon
                            let result = try decoder.decode(PokemonList.self, from: data!)
                            self.nextUrlLink = result.next // Save the next URL
                            for index in 0..<result.results.count { // Loop through each pokemon in the results list and fetch the data of each pokemon
                                self.fetchData(url: result.results[index].url, type: .pokemonData)
                            }
                        }
                        else { // If we fetch the data of each pokemon
                            let result = try decoder.decode(Pokemon.self, from: data!)
                            DispatchQueue.main.async {
                                self.pokemonImages.append(result.front_default)
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
