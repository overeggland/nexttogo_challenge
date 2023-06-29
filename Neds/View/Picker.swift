//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import SwiftUI

struct Picker: View {
    @ObservedObject var vm : PickerViewModel
    var body: some View {
        HStack(
            alignment: .bottom,
            spacing: Space_Line
        ) {
            ForEach(vm.categories.indices, id: \.self) { index in
                let category: Category = vm.categories[index]
                CategoryCell(model: category).onTapGesture {
                    vm.toggle(seletedIndex: index)
                 }.cornerRadius(15)
                  .accessibilityElement()
                  .accessibilityLabel(category.categoryName)
            }
        }.frame(height: 100).padding(.horizontal, 15)
    }
}

struct Picker_Previews: PreviewProvider {
    static var previews: some View {
//        Picker()
        Text("")
    }
}
