//
//  ImageViewModel.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import Foundation
import UIKit
@MainActor
class ImageViewModel: ObservableObject {
    @Published var photoImage: UIImage?
    
    func getImage(url: String) async {
        do {
            photoImage = try await ImageDownloadService.shared.downloadImage(url: url)
        } catch {
            print("Error in downloading image: \(error)")
        }
    }
}
