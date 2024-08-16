//
//  DataCachingApp.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import SwiftUI

@main
struct DataCachingApp: App {
    @StateObject var photoServiceRepository: PhotoServiceRepository = PhotoServiceRepository()
    @StateObject var networkMonitor: NetworkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            PhotoListView()
        }
        .environmentObject(photoServiceRepository)
        .environmentObject(networkMonitor)
    }
}
