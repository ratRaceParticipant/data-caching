//
//  PhotoListView.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import SwiftUI

struct PhotoListView: View {
    @StateObject var vm = PhotoListViewModel()
    @EnvironmentObject var photoServiceRepository: PhotoServiceRepository
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State var showInternetAlert: Bool = false
    var body: some View {
        NavigationStack {
            List(photoServiceRepository.photoData){ data in
                PhotoListItemView(photoModel: data)
            }
            .overlay(content: {
                if showInternetAlert {
                    internetStatusAlert
                }
            })
            .refreshable {
                await photoServiceRepository.fetchPhotoData2()
            }
            .listStyle(.plain)
            .onChange(of: networkMonitor.isConnected) { _, newValue in
                
                if newValue == .connected {
                    Task {
                        await photoServiceRepository.fetchPhotoData2()
                    }
                }
                toggleAlert()
            }
            .onAppear(perform: {
                if networkMonitor.isConnected == .disconnected {
                    toggleAlert()
                }
            })
            .task {
                await photoServiceRepository.fetchPhotoData2()
            }
            .navigationTitle("Data Caching")
        }
    }
    var internetStatusAlert: some View {
        Text(networkMonitor.isConnected.getNetworkStatusText())
            .foregroundStyle(.white)
            .padding()
            .background (
                networkMonitor.isConnected.getNetworkStatusColor()
                    .cornerRadius(10)
            )
            .padding(.bottom)
            .shadow (radius: 5)
            .transition(.move(edge: .top))
            .frame(maxHeight: .infinity, alignment: .top)
    }
    func toggleAlert(){
        withAnimation(.snappy) {
            showInternetAlert = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            withAnimation(.snappy) {
                showInternetAlert = false
            }
        }
    }
}

#Preview {
    PhotoListView()
}
