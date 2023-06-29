//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import Foundation

final class PickerViewModel :ObservableObject {
    @Published var categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
    }
    ///change selection state
    func toggle(seletedIndex : Int) {
        ///filter all selected categories
        ///not allowed to deselected all categories
        /*
         let condition = categories.filter({$0.isSeleted})
         guard condition.count > 1 || !categories[seletedIndex].isSeleted else {
         print("At least one selection")
         return
         }
         */
        ///change select state
        var seletedModel: Category = categories[seletedIndex]
        seletedModel.isSeleted.toggle()
        self.categories[seletedIndex] = seletedModel
    }
}
