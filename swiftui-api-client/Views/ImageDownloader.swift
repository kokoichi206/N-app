//
//  ImageDownloader.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/22.
//

import SwiftUI

class ImageDownloader : ObservableObject {
    @Published var downloadData: Data? = nil

    func downloadImage(url: String) {

        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
}

struct URLImage: View {

    let url: String
    @ObservedObject private var imageDownloader = ImageDownloader()

    init(url: String) {
        self.url = url
        self.imageDownloader.downloadImage(url: self.url)
    }

    var body: some View {
        if let imageData = self.imageDownloader.downloadData {
            let img = UIImage(data: imageData)
            return VStack {
                Image(uiImage: img!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        } else {
            return VStack {
                Image(uiImage: UIImage(systemName: "icloud.and.arrow.down")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44.0, height: 44.0)
                    
            }
        }
    }
}

struct ContentsView: View {
    private let mockMembers: [Member] = [
        .mock1
    ]

    var body: some View {
        VStack {
            URLImage(url: mockMembers[0].img)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView()
    }
}
