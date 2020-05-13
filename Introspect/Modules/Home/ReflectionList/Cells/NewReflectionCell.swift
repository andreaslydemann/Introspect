//
//  NewReflectionCell.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 18/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit
import FinniversKit

class NewReflectionCell: UICollectionViewCell {
    
    // MARK: - Private properties
    
    private lazy var plusIcon: UIImageView = {
        let imageView = UIImageView(image: R.image.plus())
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var nameLabel: Label = {
        let label = Label(style: .title3)
        label.text = "Add reflection"
        label.textAlignment = .center
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()

        view.backgroundColor = .systemTeal
        view.layer.cornerRadius = 20
        view.dropShadow(color: .black,
                                  opacity: 0.25,
                                  offset: CGSize(width: 5, height: 5),
                                  radius: 5)

        return view
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
        containerView.addSubviews(plusIcon, nameLabel)
        contentView.addSubview(containerView)

        containerView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: .spacingS,
                                            left: .spacingS,
                                            bottom: .spacingS,
                                            right: .spacingS))

        plusIcon.centerInSuperview(size: CGSize(width: 50, height: 50))

        nameLabel.anchor(top: plusIcon.bottomAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: nil,
                         trailing: containerView.trailingAnchor,
                         padding: .init(top: .spacingM))
    }
}
