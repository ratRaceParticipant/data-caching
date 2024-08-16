//
//  ImageDownloadService.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import Foundation
import UIKit
class ImageDownloadService {
    
    static let shared = ImageDownloadService()
    
    private init() {}
    
    func downloadImage(url: String) async throws -> UIImage? {
        
        do {
            let urlString = URL(string: url)
            guard let url = urlString else {return nil}
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            
            return UIImage(data: data)
        } catch {
            throw URLError(.badServerResponse)
        }
        
    }
}
