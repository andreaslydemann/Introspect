//
//  HomeViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 04/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import SFSafeSymbols
import UI
import UIKit

struct User {
    let name: String
}

class HomeViewController: UIViewController {
    private var user: User?

    convenience init(user: User) {
        self.init()
        self.user = user
    }

    lazy var greetingLabel: UILabel = {
        let label = UILabel()

        guard let user = user else { fatalError("No user was passed") }

        label.text = user.name.isEmpty ? "" : "Hi, " + user.name
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()

    private let checkInListViewController = CheckInListViewController(checkIns: [CheckIn(date: Date()),
                                                                                 CheckIn(date: Date(fromString: "2009-08-11", format: .isoDate)!)])

    private let reportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemSymbol: .chartBar), for: .normal)
        return button
    }()

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemSymbol: .gear), for: .normal)
        return button
    }()

    private lazy var footerView: UIStackView = {
        let footerView = UIStackView(arrangedSubviews: [reportButton, settingsButton])
        footerView.distribution = .equalSpacing
        return footerView
    }()

    func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubviews(greetingLabel, checkInListViewController.view, footerView)
        addChild(checkInListViewController)

        checkInListViewController.delegate = self

        greetingLabel.anchor(top: view.topAnchor,
                             leading: view.layoutMarginsGuide.leadingAnchor,
                             bottom: checkInListViewController.view.topAnchor,
                             trailing: view.layoutMarginsGuide.trailingAnchor,
                             padding: .init(top: 100, left: 0, bottom: 15, right: 0))

        checkInListViewController.view.anchor(top: greetingLabel.bottomAnchor,
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
