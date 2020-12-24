//
//  MainPageCategoriesCollectionViewCell.swift
//  Tourme
//
//  Created by Dua Almahyani on 22/12/2020.
//

import UIKit

class MainPageCategoriesCollectionViewCell: UICollectionViewCell {
    
    let categoryImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 63, height: 63))
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "ResturantIcon")
        image.clipsToBounds = true
        return image
    }()
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:8)
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.layer.cornerRadius = 9.0
        stack.spacing = 5
        
        stack.addArrangedSubview(categoryImage)
        stack.addArrangedSubview(categoryNameLabel)
        
        return stack
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
