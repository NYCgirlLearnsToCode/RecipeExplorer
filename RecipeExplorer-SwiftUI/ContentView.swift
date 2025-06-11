//
//  ContentView.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = RecipeViewModel()
    @State private var searchText = ""

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return viewModel.recipes
        } else {
            return viewModel.recipes.filter { $0.cuisine.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredRecipes) { recipe in
                HStack(alignment: .center) {
                    VStack(alignment: .center) {
                        if let url = URL(string: recipe.photo_url_small) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 100)
                        }
                        Text(recipe.cuisine)
                    }
                    Text(recipe.name)
                }
            }
            .searchable(text: $searchText, prompt: "Search by cuisine")
            .task {
                await viewModel.getRecipes()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
        .navigationTitle("Recipe Explorer")
    }
}

#Preview {
    ContentView()
}
