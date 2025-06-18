//
//  RecipeDataModel.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/3/25.
//

import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading = false
    
    private let apiService: RecipeServiceProtocol
    
    init(apiService: RecipeServiceProtocol = RecipeService()) {
        self.apiService = apiService
    }
    
    func getRecipes() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedRecipes = try await apiService.loadRecipes()
            self.recipes = fetchedRecipes
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
