//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation

struct CellViewModel {
    let model : RaceSummary
    let raceInfo : RaceInfoExtra
    
    func imageName() -> String {
        FileService.iconNameMap[model.categoryId] ?? ""
    }
}
