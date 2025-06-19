//
//  RecipeDetailView.swift
//  RecipeExplorer-SwiftUI
//
//  Created by Lisa J on 6/11/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var showWebView = false
    @State private var showYouTubeView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Hero Image
                if let url = URL(string: recipe.photoUrlLarge) {
                    CachedAsyncImage(url: url)
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Cuisine
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(recipe.cuisine)
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        if let sourceUrl = recipe.sourceUrl {
                            Button(action: {
                                showWebView = true
                            }) {
                                HStack {
                                    Image(systemName: "doc.text")
                                    Text("View Recipe Source")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                            .sheet(isPresented: $showWebView) {
                                if let url = URL(string: sourceUrl) {
                                    WebView(url: url)
                                }
                            }
                        }
                        
                        if let youtubeUrl = recipe.youtubeUrl {
                            Button(action: {
                                showYouTubeView = true
                            }) {
                                HStack {
                                    Image(systemName: "play.rectangle")
                                    Text("Watch on YouTube")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                            .sheet(isPresented: $showYouTubeView) {
                                if let url = URL(string: youtubeUrl) {
                                    WebView(url: url)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(cuisine: "Italian", name: "Pasta", photoUrlLarge: "https://example.com/large.jpg", photoUrlSmall: "https://example.com/small.jpg", sourceUrl: nil, uuid: "12345", youtubeUrl: nil))
}
