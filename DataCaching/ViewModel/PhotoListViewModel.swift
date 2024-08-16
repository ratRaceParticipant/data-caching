//
//  PhotoListViewModel.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 11/08/24.
//

import Foundation
@MainActor
class PhotoListViewModel: ObservableObject {
    @Published var photoModelData: [PhotoModel] = []
    let photoServiceRepository = PhotoServiceRepository()
    
    func fetchData() async {
        photoModelData = await photoServiceRepository.fetchPhotoData()
    }
}
