//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation

struct Network {
    
    static func fetchNextRacesInfo(count: Int) async throws -> [String: RaceSummary] {
        guard count < Config.kMaxCount else {
            throw NetworkError.loadCountTooLarge
        }
        print("request count = \(count)")
        let url: URL = URL(string: Config.kNextRacesUrl+"\(count)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let model = try JSONDecoder().snake.decode(NextToGoModel.self, from: data)
            if model.status == 200 && !model.data.raceSummaries.isEmpty {
                return model.data.raceSummaries
            } else {
                throw NetworkError.unableToGetDataFile
            }
        } catch {
            throw NetworkError.unableToParseJSONDataFile
        }
    }
    
}

enum NetworkError: String, Error {
    case loadCountTooLarge
    case unableToGetDataFile
    case unableToParseJSONDataFile
}

enum GeneralError : String, Error  {
    case notEnoughDataFound
}


