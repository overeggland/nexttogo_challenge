//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation
 
extension JSONDecoder {
    var snake : JSONDecoder {
        self.keyDecodingStrategy = .convertFromSnakeCase
        return self
    }
}

struct FileService {
    
    static let categoryModel : PickerViewModel = FileService().fetchJsonFile()
    
    func fetchJsonFile() -> PickerViewModel {
        let temp = PickerViewModel(categories: [])
        
        guard let url = Bundle.main.url(forResource: "CategoriesConfig", withExtension: "json") else {
            return temp
        }
        
        do {
            let data = try Data(contentsOf: url)
            let fileData = try JSONDecoder().snake.decode([Category].self, from: data)
            return PickerViewModel(categories: fileData)
        } catch {
            print(error.localizedDescription)
        }
        return temp
    }
    
    /// icon map
    static var iconNameMap = {
        var map : [String:String]  = [:]
        FileService.categoryModel.categories.forEach {map[$0.categoryId] = $0.iconName}
        return map
    }()
}
