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
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let plusIcon: UIImageView = {
        let image = UIImage(systemName: "plus")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Add check-in"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    func setupViews() {
        
        let backgroundView = UIView()
        
        backgroundView.addSubviews(plusIcon, nameLabel)
        
        backgroundView.backgroundColor = .systemTeal
        contentView.addSubview(backgroundView)
        
        backgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        plusIcon.centerInSuperview(size: CGSize(width: 60, height: 60))
        nameLabel.anchor(top: plusIcon.bottomAnchor, leading: backgroundView.leadingAnchor, bottom: nil, trailing: backgroundView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        backgroundView.layer.shadowOffset = .init(width: backgroundView.frame.width + 4, height:  backgroundView.frame.height + 4)
        backgroundView.layer.cornerRadius = 4
        backgroundView.layer.shadowRadius = 4
        backgroundView.layer.shadowOpacity = 0.23
        backgroundView.layer.shadowColor = UIColor.black.cgColor
    }
}
