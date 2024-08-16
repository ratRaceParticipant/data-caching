//
//  Enums.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 16/08/24.
//

import Foundation
import SwiftUI

enum NetworkStatus {
    case connected
    case disconnected
    
    func getNetworkStatusColor() -> Color {
        switch self {
        case .connected:
            return Color.green
        case .disconnected:
            return Color.red
       
        }
    }
    
    func getNetworkStatusText() -> String {
        switch self {
        case .connected:
            return "Connected To Internet"
        case .disconnected:
            return "No Internet"
        }
    }
}
