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
    let photoUrlLarge: String
    let photoUrlSmall: String
    let sourceUrl: String?
    let uuid: String
    let youtubeUrl: String?
    
    var id: String { uuid }
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case uuid
        case youtubeUrl = "youtube_url"
    }
}
