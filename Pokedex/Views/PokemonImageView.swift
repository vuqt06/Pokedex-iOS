//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Vu Trinh on 9/12/22.
//

import SwiftUI
// The usable SwiftUI view for pokemon images by passing an URL as an argument
struct PokemonImageView: View {
    var url: String
    var body: some View {
        if let cachedImage = CacheService.getImage(forKey: url) {
            // Image is in cache so lets use it
            cachedImage
        } else {
            AsyncImage(url: URL(string: url)) {
                phase in
                
                switch phase {
                case AsyncImagePhase.empty:
                    // Currently fetching
                    ProgressView()
                case AsyncImagePhase.success(let image):
                    // Display the fetched image
                    image
                        .onAppear {
                            // Save this image into cache
                            CacheService.setImage(image: image, forKey: url)
                        }
                case AsyncImagePhase.failure(_):
                    // Could not fetch the profile photo
                    Text("?")
                        .bold()
                }
            }
        }
    }
}
