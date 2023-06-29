//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import UIKit
import SwiftUI

private let themeColor = UIColor(red: 1, green: 106/255.0, blue: 16/255.0, alpha: 1)

struct CategoryCell: UIViewRepresentable {
    
    let model: Category
    typealias UIViewType = CellContent
    
    func makeUIView(context: Context) -> CellContent {
        return CellContent(model: model)
    }
    
    func updateUIView(_ uiView: CellContent, context: Context) {
        uiView.updateUI(model: model)
    }
}

final class CellContent : UIView {
    private let unselectedBgColor =  UIColor.systemBackground
    private var model : Category
    
    init(model:Category) {
        self.model = model
        super.init(frame: CGRectZero)
        
        self.layer.borderWidth = 2;
        self.updateUI(model: model)
    }
    
    func updateUI(model:Category) {
        self.model = model
        self.layer.borderColor = model.isSeleted ? themeColor.cgColor : UIColor.clear.cgColor
        self.backgroundColor = model.isSeleted ? themeColor : .lightGray
        
        nameLabel.text = model.categoryName.components(separatedBy: " ").first
        imageView.image = UIImage(named: model.iconName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var nameLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -5),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 45),
            label.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
       return label
    }()
    
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        return imageView
    }()
}
