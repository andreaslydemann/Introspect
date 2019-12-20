//
//  CreateCheckInCell.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 18/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

class CreateCheckInCell: UICollectionViewCell {
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

    let plusIcon: UIImageView = {
        let image = UIImage(systemName: "plus")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Add check-in"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    let containerView: UIView = {
        let backgroundView = UIView()

        backgroundView.backgroundColor = .systemTeal
        backgroundView.layer.shadowOffset = .init(width: backgroundView.frame.width + 2, height: backgroundView.frame.height + 2)
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
                             padding: .init(top: 8, left: 8, bottom: 8, right: 8))

        plusIcon.centerInSuperview(size: CGSize(width: 60, height: 60))

        nameLabel.anchor(top: plusIcon.bottomAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: nil,
                         trailing: containerView.trailingAnchor,
                         padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
