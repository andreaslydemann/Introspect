//
//  CompletedCheckInCell.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 18/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

class CompletedCheckInCell: UICollectionViewCell {
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Jan"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    let containerView: UIView = {
        let backgroundView = UIView()

        backgroundView.backgroundColor = .systemTeal
        backgroundView.layer.shadowOffset = .init(width: backgroundView.frame.width + 2, height: backgroundView.frame.height + 2)
        backgroundView.layer.cornerRadius = 4
        backgroundView.layer.shadowRadius = 4
        backgroundView.layer.shadowOpacity = 0.23
        backgroundView.layer.shadowColor = UIColor.black.cgColor

        return backgroundView
    }()

    func setupViews() {
        containerView.addSubviews(dayLabel, monthLabel)
        contentView.addSubview(containerView)

        containerView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: 8, left: 4, bottom: 8, right: 4))

        dayLabel.anchor(top: containerView.topAnchor,
                        leading: containerView.leadingAnchor,
                        bottom: containerView.bottomAnchor,
                        trailing: containerView.trailingAnchor)

        monthLabel.anchor(top: dayLabel.bottomAnchor,
                          leading: containerView.leadingAnchor,
                          bottom: nil,
                          trailing: containerView.trailingAnchor,
                          padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
