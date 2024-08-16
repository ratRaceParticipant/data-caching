# Data Caching App with Core Data

## Overview

This iOS app demonstrates how to implement data caching using Core Data. The app caches API responses and other frequently accessed data locally, providing fast access and offline functionality. Core Data is used as the primary caching mechanism, offering a robust and scalable solution for managing and persisting data.

## Features

- **Local Data Caching**: Cache API responses using Core Data.
- **Offline Mode**: Access cached data when the app is offline.
- **Cache Management**: Automatic cache invalidation, data expiration handling.

## Technologies Used

- **iOS SDK**: Built using Xcode 15.
- **Core Data**: Used for local data persistence and caching.
- **URLSession**: For making network requests and fetching data from APIs.
- **Swift**: Developed in Swift 5 for performance and safety.

## Getting Started

### Prerequisites

- Xcode 15 or later
- iOS 17.0 or later

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/data-caching-app.git
   cd data-caching-app
   ```

2. **Open the Project in Xcode**
   ```bash
   open DataCachingApp.xcodeproj
   ```

3. **Install Dependencies**
   If you use external libraries (e.g., via CocoaPods or Swift Package Manager), make sure they are installed.

4. **Run the App**
   - Select the target device or simulator.
   - Press `Cmd + R` or click the "Run" button in Xcode.

### Project Structure

- **Model**: Contains the Core Data models, including entities and attributes.
- **ViewModel**: Manages the logic for fetching, caching, and invalidating data.
- **View**: The UI layer of the app, displaying data and handling user interactions.
- **Network**: Responsible for making API calls and handling responses.

### Core Data Implementation

1. **Core Data Model**:
   - The app uses a Core Data model (`.xcdatamodeld`) with entities representing different types of data, such as `User`, `Post`, and `ImageCache`.

2. **Fetching and Caching Data**:
   - Data is fetched from the API using `URLSession`.
   - The response is parsed and saved into Core Data entities.
   - Future requests check the local Core Data store before making network calls to reduce data usage and improve performance.

   ```swift
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
   ```

3. **Cache Invalidation**:
   - Cached data is invalidated based on certain criteria, such as time-based expiration or user-triggered events.
   - Manual cache clearing is also available in the app settings.

   ```swift
   private func deletePreviousData(){
        let context = dataManager.viewContext
        do {
            let cachedData = try loadCachedProducts()
            for data in cachedData {
                context.delete(data)
            }
            dataManager.saveData()
        } catch {
            print("Error fetching previous data: \(error)")
        }
    }
   ```


### Contributions

Contributions are welcome! If you'd like to contribute, please fork the repository and submit a pull request.

### Contact

- **Himanshu Karamchandani**: himanshu.karamchandani8@gmail.com
- **GitHub**: https://github.com/ratRaceParticipant

---

This `README.md` provides a clear overview of the project, instructions for setup, and information about the implementation of data caching with Core Data. Adjust the content to fit your specific app and use case.
