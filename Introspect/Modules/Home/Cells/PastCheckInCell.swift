//
//  CompletedCheckInCell.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 18/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

class PastCheckInCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet { layer.opacity = isSelected ? 0.5 : 1 }
    }
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "22"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Jan"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2020"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.alpha = 0.5
        label.textAlignment = .center
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Feeling good"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.layer.shadowOffset = .init(width: containerView.frame.width + 2, height: containerView.frame.height + 2)
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.23
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.clipsToBounds = true
        return containerView
    }()
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: R.image.matteoCatanese())
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.frame = containerView.frame
        return imageView
    }()
    
    lazy var dateView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, monthLabel, yearLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(backgroundImage)
        backgroundImage.addSubviews(dateView, ratingLabel)
        
        containerView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: 8, left: 0, bottom: 8, right: 0))
        
        backgroundImage.layoutMargins = .init(top: 24, left: 24, bottom: 36, right: 24)
        
        dateView.anchor(top: backgroundImage.layoutMarginsGuide.topAnchor,
                        leading: backgroundImage.layoutMarginsGuide.leadingAnchor,
                        bottom: nil,
                        trailing: nil)
        
        ratingLabel.anchor(top: nil,
                           leading: backgroundImage.layoutMarginsGuide.leadingAnchor,
                           bottom: backgroundImage.layoutMarginsGuide.bottomAnchor,
                           trailing: backgroundImage.layoutMarginsGuide.trailingAnchor)
    }
}
