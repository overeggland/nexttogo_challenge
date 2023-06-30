//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation

enum RaceCategory : String {
    case greyhoundCategory = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harnessCategory = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case horseCategory = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
}

final class ViewModel: ObservableObject {
    
    /// selected all races
    @Published var seletedRaceList:[RaceSummary] = []
    
    /// Picker ViewModel
    var categoriesVM: PickerViewModel = FileService.categoryModel
    
    /// all Races
    var allRaceList:[RaceSummary] = []
    
    /// the categories that user has selected
    var seletedCategoryIDList:[String] = []
    
    /// net work load race count
    private var count = 20
    
    /// stop repeat request
    private var requesting = false
    
    /// UI updated
    func updateUIData() {
        print("updateData")
        
        self.seletedCategoryIDList = self.categoriesVM.categories.filter{ $0.isSeleted }.map { $0.categoryId }
        
        // iterate the data source
        var count: Int = 0
        let filterList = self.allRaceList.filter {
            guard count < Config.kDisplayNumber else {
                return false
            }
            if (self.seletedCategoryIDList.isEmpty || self.seletedCategoryIDList.contains($0.categoryId)) {
                if ($0.advertisedStart.timeStamp - Date().timeIntervalSince1970) > Config.kExpireInterval {
                    count += 1
                    return true
                }
            }
            return false
        }
        
        // less than 5 reload
        if filterList.count < Config.kDisplayNumber {
            // stop repeat
            if self.requesting {
                return
            }
            Task {
                await self.fetchRaceList()
            }
        } else {
            DispatchQueue.main.async {
                self.seletedRaceList = filterList
            }
        }
    }
    
    /// network loadwork
    func fetchRaceList() async {
        self.requesting = true
        do {
            let orginData = try await Network.fetchNextRacesInfo(count: self.count)
            let filter = self.filterRaceData(raw: orginData)
            
            switch filter {
            case .failure(_):
                // not enough data, enlarge the number of data loading.
                self.count *= 2;
                await self.fetchRaceList()
            case .success(let data):
                self.allRaceList = data
                self.requesting = false
                self.updateUIData()
            }
        } catch {
            print(error.localizedDescription)
            self.requesting = false
        }
    }
    
    /// filter races
    private func filterRaceData(raw:[String: RaceSummary]) -> Result<[RaceSummary], Error> {
        let nowTimeStamp = Date().timeIntervalSinceNow
        var greyhoundCount = 0, harnessCount = 0, horseCount = 0
        
        do {
            ///1. frist transform to array
            ///2. filter those unexpired races
            ///3. ordered by start time
            let result = try raw.map { $0.value }.filter {
                let include = ($0.advertisedStart.timeStamp - nowTimeStamp) > Config.kExpireInterval
                if include {
                    switch RaceCategory(rawValue: $0.categoryId) {
                    case .greyhoundCategory: greyhoundCount += 1
                    case .harnessCategory: harnessCount += 1
                    case .horseCategory: horseCount += 1
                    case .none: print("Category Id not found")
                    }
                    
                    /// if one category has less than 5 races
                    /// we set 100 as max datapool benchmark
                    if raw.count == self.count,
                       let _ = [greyhoundCount, harnessCount, horseCount].first(where:{$0>Config.kDisplayNumber})
                    {
                        throw GeneralError.notEnoughDataFound
                    }
                }
                return include
            }.sorted(by: { $0.advertisedStart < $1.advertisedStart })
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
