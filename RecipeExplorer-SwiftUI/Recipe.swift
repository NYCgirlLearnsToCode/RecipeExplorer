//
//  Recipe.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/3/25.
//

import Foundation


struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let cuisine: String
    let name: String
    // TODO: update naming & possible nil values
    let photo_url_large: String
    let photo_url_small: String
    let source_url: String?
    let uuid: String
    let youtube_url: String?
    
    var id: String { uuid }
}
