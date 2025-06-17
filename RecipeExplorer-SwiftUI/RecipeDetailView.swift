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
            VStack(alignment: .leading, spacing: 16) {
                if let url = URL(string: recipe.photo_url_large) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                }
                Text(recipe.name)
                    .font(.title)
                Text(recipe.cuisine)
                    .font(.headline)
                
                if let sourceUrl = recipe.source_url {
                    Button(action: {
                        showWebView = true
                    }) {
                        Text("View Recipe Source")
                            .foregroundColor(.blue)
                            .underline()
                    }
                    .sheet(isPresented: $showWebView) {
                        if let url = URL(string: sourceUrl) {
                            WebView(url: url)
                        }
                    }
                }
                
                if let youtubeUrl = recipe.youtube_url {
                    Button(action: {
                        showYouTubeView = true
                    }) {
                        Text("Watch on YouTube")
                            .foregroundColor(.blue)
                            .underline()
                    }
                    .sheet(isPresented: $showYouTubeView) {
                        if let url = URL(string: youtubeUrl) {
                            WebView(url: url)
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(cuisine: "Italian", name: "Pasta", photo_url_large: "https://example.com/large.jpg", photo_url_small: "https://example.com/small.jpg", source_url: nil, uuid: "12345", youtube_url: nil))
}
