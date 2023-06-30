//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation

/*--------------- Local Config---------------*/
// MARK: - Category
struct Category: Decodable {
    let categoryName : String
    let categoryId : String
    let iconName : String
    var isSeleted : Bool
}


/*--------------- NetWork ---------------*/
// MARK: - NextToGoModel
struct NextToGoModel: Decodable {
    let status: Int
    let data: DataClass
    let message: String
    
    // MARK: - DataClass
    struct DataClass: Decodable {
        let nextToGoIds: [String]
        let raceSummaries: [String: RaceSummary]
    }
}

// MARK: - RaceSummary
struct RaceSummary: Decodable {
    let raceId: String
    let raceName: String?
    let raceNumber: Int
    let meetingId, meetingName, categoryId: String
    let advertisedStart: AdvertisedStart
}

// MARK: - AdvertisedStart
struct AdvertisedStart: Decodable, Comparable {
    let seconds: Int
    
    static func > (lhs: Self, rhs: Self) -> Bool {
        lhs.seconds > rhs.seconds
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.seconds < rhs.seconds
    }
    
    init(seconds: Int) {
        self.seconds = seconds
    }
}

extension AdvertisedStart {
    var timeStamp : TimeInterval {
        TimeInterval(self.seconds)
    }
}
