//
//  HomeViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 04/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UI
import UIKit

class HomeViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi Andreas"
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()

    private let checkInListViewController = CheckInListViewController()

    private let reportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chart.bar"), for: .normal)
        return button
    }()

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        return button
    }()

    private lazy var footerView: UIStackView = {
        let footerView = UIStackView(arrangedSubviews: [reportButton, settingsButton])
        footerView.distribution = .equalSpacing
        return footerView
    }()

    func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubviews(nameLabel, checkInListViewController.view, footerView)
        addChild(checkInListViewController)

        checkInListViewController.delegate = self

        nameLabel.anchor(top: view.topAnchor,
                         leading: view.layoutMarginsGuide.leadingAnchor,
                         bottom: checkInListViewController.view.topAnchor,
                         trailing: view.layoutMarginsGuide.trailingAnchor,
                         padding: .init(top: 100, left: 0, bottom: 15, right: 0))

        checkInListViewController.view.anchor(top: nameLabel.bottomAnchor,
                                              leading: view.leadingAnchor,
                                              bottom: nil,
                                              trailing: view.trailingAnchor,
                                              padding: .init(top: 15, left: 0, bottom: 15, right: 0))

        footerView.anchor(top: checkInListViewController.view.bottomAnchor,
                          leading: view.layoutMarginsGuide.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.layoutMarginsGuide.trailingAnchor,
                          size: .init(width: 0, height: 50))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension HomeViewController: CheckInListViewControllerDelegate {
    public func didSelectCheckIn(_ userId: String, viewController _: CheckInListViewController) {
        print(userId)
    }
}