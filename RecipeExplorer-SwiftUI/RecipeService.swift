//
//  RecipeFetcher.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/3/25.
//

import Foundation

class RecipeService {
    func loadRecipes() async throws -> [Recipe] {
        // check cache for data first
        
        // fall back to network
        
        // save to cache
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw URLError(.badURL)
        }
           
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
        
        guard let httpsResponse = urlResponse as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return decoded.recipes
    }
}
