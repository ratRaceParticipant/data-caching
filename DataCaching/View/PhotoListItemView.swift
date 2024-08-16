//
//  PhotoListItemView.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import SwiftUI

struct PhotoListItemView: View {
    var photoModel: PhotoModel
    var body: some View {
        HStack {
            ImageView(imageUrl: photoModel.url)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(photoModel.title)
                    .fontWeight(.bold)
                Text(photoModel.url)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    PhotoListItemView(photoModel: PhotoModel.sampleData)
}
