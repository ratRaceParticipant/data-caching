//
//  PhotoService.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import Foundation

class PhotoService {
    static let shared = PhotoService()
    
    private init() {}
    
    func fetchData() async throws -> [PhotoModel] {
        do {
            let urlString = URL(string: "https://jsonplaceholder.typicode.com/photos")
            guard let url = urlString else {return []}
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let photoData = try decoder.decode([PhotoModel].self, from: data)
            return photoData
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}
