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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let plusIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let nameLabel: Label = {
        let label = Label(style: .title3)
        label.text = "Add reflection"
        label.textAlignment = .center
        return label
    }()

    let containerView: UIView = {
        let backgroundView = UIView()

        backgroundView.backgroundColor = .systemTeal
        backgroundView.layer.shadowOffset =
            .init(width: backgroundView.frame.width + 2,
                  height: backgroundView.frame.height + 2)
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.shadowRadius = 4
        backgroundView.layer.shadowOpacity = 0.23
        backgroundView.layer.shadowColor = UIColor.black.cgColor

        return backgroundView
    }()

    func setupViews() {
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
