//
//  ContentView.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        List(viewModel.recipes) { recipe in
            Text(recipe.name)
        }
        .task {
            await viewModel.getRecipes()
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

#Preview {
    ContentView()
}
