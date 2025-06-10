//
//  RecipeDataModel.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/3/25.
//

import SwiftUI

@MainActor

class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    
    let apiService = RecipeService()
    
    func getRecipes() async {
        do {
            let fetchedRecipes = try await apiService.loadRecipes()
            self.recipes = fetchedRecipes
            print(fetchedRecipes)
        } catch {
            self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
        }
    }
}
