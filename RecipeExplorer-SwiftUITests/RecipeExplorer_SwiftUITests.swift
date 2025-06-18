//
//  RecipeExplorer_SwiftUITests.swift
//  RecipeExplorer-SwiftUITests
//
//  Created by Lisa J on 6/3/25.
//

import Testing
import UIKit
@testable import RecipeExplorer_SwiftUI

struct RecipeExplorer_SwiftUITests {

    @Test func testImageCacheMemoryAndDisk() async throws {
        let cache = ImageCache.shared
        let key = "test-key"
        let image = UIImage(systemName: "star")!
        cache.setImage(image, forKey: key)
        let loaded = cache.image(forKey: key)
        #expect(loaded != nil)
    }

    @Test func testViewModelLoadsRecipes() async throws {
        actor MockRecipeService: RecipeServiceProtocol {
            func loadRecipes() async throws -> [Recipe] {
                return [Recipe(cuisine: "Test", name: "Test Recipe", photo_url_large: "", photo_url_small: "", source_url: nil, uuid: "1", youtube_url: nil)]
            }
        }
        let viewModel = await RecipeViewModel(apiService: MockRecipeService())
        await viewModel.getRecipes()
        await MainActor.run {
            #expect(viewModel.recipes.count == 1)
            #expect(viewModel.recipes.first?.name == "Test Recipe")
        }
    }

    @Test func testViewModelHandlesError() async throws {
        actor FailingRecipeService: RecipeServiceProtocol {
            func loadRecipes() async throws -> [Recipe] {
                throw URLError(.badServerResponse)
            }
        }
        let viewModel = await RecipeViewModel(apiService: FailingRecipeService())
        await viewModel.getRecipes()
        await MainActor.run {
            #expect(viewModel.errorMessage != nil)
        }
    }
}
