//
//  NetworkMonitor.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 16/08/24.
//

import Foundation
import Network


final class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected: NetworkStatus = .disconnected
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied ? .connected : .disconnected
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
