//
//  CompletedReflectionCell.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 18/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit
import FinniversKit

class PastReflectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dayLabel: Label = {
        let label = Label(style: .title3)
        label.text = "22"
        label.textAlignment = .center
        return label
    }()
    
    let monthLabel: Label = {
        let label = Label(style: .title3)
        label.text = "Jan"
        label.textAlignment = .center
        return label
    }()
    
    let yearLabel: Label = {
        let label = Label(style: .title3)
        label.text = "2020"
        label.alpha = 0.5
        label.textAlignment = .center
        return label
    }()
    
    let ratingLabel: Label = {
        let label = Label(style: .title2)
        label.text = "Feeling good"
        label.textAlignment = .center
        return label
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.layer.shadowOffset = .init(width: containerView.frame.width + 2,
                                                 height: containerView.frame.height + 2)
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
                             padding: .init(top: .spacingS, bottom: .spacingS))
        
        backgroundImage.layoutMargins = .init(top: .spacingL,
                                              left: .spacingL,
                                              bottom: .spacingXL,
                                              right: .spacingL)
        
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
