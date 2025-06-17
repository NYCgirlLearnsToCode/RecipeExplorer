//
//  RecipeFetcher.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/3/25.
//

import Foundation

actor RecipeService {
    private var cache: [Recipe]?
    private let cacheKey = "cached_recipes"
    private let cacheExpirationInterval: TimeInterval = 3600 // 1 hour
    
    private var lastFetchTime: Date?
    
    func loadRecipes() async throws -> [Recipe] {
        // Check if we have valid cached data
        if let cachedRecipes = cache,
           let lastFetch = lastFetchTime,
           Date().timeIntervalSince(lastFetch) < cacheExpirationInterval {
            return cachedRecipes
        }
        
        // Fetch from network
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw URLError(.badURL)
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let httpsResponse = urlResponse as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
        
        // Update cache
        cache = decoded.recipes
        lastFetchTime = Date()
        
        return decoded.recipes
    }
    
    func clearCache() {
        cache = nil
        lastFetchTime = nil
    }
}
