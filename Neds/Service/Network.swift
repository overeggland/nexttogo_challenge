//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation

struct Network {
    
    static func fetchNextRacesInfo(count: Int) async throws -> [String: RaceSummary] {
        guard count < Config.kMaxCount + 1 else {
            throw NetworkError.loadCountTooLarge
        }
        print("network load = \(count)")
        let url: URL = URL(string: Config.kNextRacesUrl+"\(count)")!
        
        do {
            ///request
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5.0)
            
            ///header
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Content-type": "application/json"]
            let session = URLSession(configuration: configuration)
            
            ///URLSession
            let (data, _) = try await session.data(for: request)

            ///decoder
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


