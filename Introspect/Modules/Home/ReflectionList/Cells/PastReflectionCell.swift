//
//  PastReflectionCell.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 18/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit
import FinniversKit

class PastReflectionCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private lazy var dayLabel: Label = {
        let label = Label(style: .title3)
        label.text = "22"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var  monthLabel: Label = {
        let label = Label(style: .title3)
        label.text = "Jan"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var  yearLabel: Label = {
        let label = Label(style: .title3)
        label.text = "2020"
        label.alpha = 0.5
        label.textAlignment = .center
        return label
    }()
    
    private lazy var  ratingLabel: Label = {
        let label = Label(style: .title2)
        label.text = "Feeling good"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var  containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        return containerView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: R.image.matteoCatanese())
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.frame = containerView.frame
        return imageView
    }()
    
    private lazy var dateView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, monthLabel, yearLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setup() {
        addBackgroundShadow(to: contentView)
        
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
    
    private func addBackgroundShadow(to view: UIView) {
        view.dropShadow(color: .black,
                        opacity: 0.25,
                        offset: CGSize(width: 5, height: 5),
                        radius: 5)
    }
}
