//
//  PhotoServiceRepository.swift
//  DataCaching
//
//  Created by Himanshu Karamchandani on 15/08/24.
//

import Foundation
import CoreData
@MainActor
class PhotoServiceRepository: ObservableObject {
    private let photoService = PhotoService.shared
    private let dataManager = CoreDataHandler.shared
    @Published var photoData: [PhotoModel] = []
    
    func fetchPhotoData() async -> [PhotoModel] {
        do {
            let cachedData = try loadCachedProducts()
            if !cachedData.isEmpty {
                return cachedData.map { mapPhotoEntityToModel(photoEntity: $0) }
            } else {
                let photoData = try await photoService.fetchData()
                await savePhotoDataToCoreData(photoData: photoData)
                return photoData
            }
        } catch {
            print("Error in fetching data")
            return []
        }
    }
    
    func fetchPhotoData2() async {
        do {
            let cachedData = try loadCachedProducts()
            if !cachedData.isEmpty {
                photoData = cachedData.map { mapPhotoEntityToModel(photoEntity: $0) }
            } 
            let fetchedPhotoData = try await photoService.fetchData()
            
            if !fetchedPhotoData.isEmpty {
                photoData = fetchedPhotoData
                await savePhotoDataToCoreData(photoData: photoData)
            }
        } catch {
            print("Error in fetching data")
            
        }
    }
    
    private func loadCachedProducts() throws -> [PhotoEntity] {
            let request: NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()
            return try dataManager.viewContext.fetch(request)
    }
    
    private func savePhotoDataToCoreData(photoData: [PhotoModel]) async {
        let context = dataManager.viewContext
        
        await context.perform {
            self.deletePreviousData()
            for data in photoData.prefix(10) {
                let photoEntity = PhotoEntity(context: context)
                self.mapPhotoModelToEntity(photoModel: data, photoEntity: photoEntity)
            }
            self.dataManager.saveData()
        }
    }
    
    private func mapPhotoModelToEntity(photoModel: PhotoModel, photoEntity: PhotoEntity){
        photoEntity.id = Int64(photoModel.id)
        photoEntity.title = photoModel.title
        photoEntity.albumId = Int64(photoModel.albumId)
        photoEntity.thumbnailUrl = photoModel.thumbnailUrl
        photoEntity.url = photoModel.url
    }
    
    private func mapPhotoEntityToModel(photoEntity: PhotoEntity) -> PhotoModel{
        return PhotoModel(
            albumId: Int(photoEntity.albumId),
            id: Int(photoEntity.id),
            title: photoEntity.title ?? "",
            url: photoEntity.url ?? "",
            thumbnailUrl: photoEntity.thumbnailUrl ?? ""
        )
    }
    
    private func deletePreviousData(){
        let context = dataManager.viewContext
        do {
            let cachedData = try loadCachedProducts()
            for data in cachedData {
                context.delete(data)
                dataManager.saveData()
            }
        } catch {
            print("Error fetching previous data: \(error)")
        }
    }
    
}
