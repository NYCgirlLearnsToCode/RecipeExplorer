import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    @State private var uiImage: UIImage?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Color.clear // Reserve space for the image
            }
            if isLoading || uiImage == nil {
                ProgressView()
            }
        }
        .task {
            await loadImage()
        }
    }

    private func loadImage() async {
        guard let url = url else { return }
        let key = url.absoluteString
        await MainActor.run { isLoading = true }

        if let cached = ImageCache.shared.image(forKey: key) {
            await MainActor.run {
                uiImage = cached
                isLoading = false
            }
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                ImageCache.shared.setImage(image, forKey: key)
                await MainActor.run {
                    uiImage = image
                    isLoading = false
                }
            } else {
                await MainActor.run { isLoading = false }
            }
        } catch {
            await MainActor.run { isLoading = false }
        }
    }
} 