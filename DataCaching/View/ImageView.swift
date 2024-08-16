//
//  ImageView.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import SwiftUI

struct ImageView: View {
    @StateObject var loader = ImageViewModel()
    var imageUrl: String
    var body: some View {
        Group {
            if let image = loader.photoImage {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            } else {
                ProgressView()
            }
        }
        .task {
            await loader.getImage(url: imageUrl)
        }
    }
}

#Preview {
    ImageView(imageUrl: PhotoModel.sampleData.url)
}
