//
//  CheckInCollectionViewCell.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 04/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

class CheckInCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Disney Build It: Frozen"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        backgroundColor = .red
        
        nameLabel.frame = CGRect(x:0, y: 0, width: frame.width, height: frame.width)
        categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 200)
    }
}
