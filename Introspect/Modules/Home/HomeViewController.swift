//
//  HomeViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 04/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import SFSafeSymbols
import UIKit
import FinniversKit

class HomeViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var user: User?
    
    private let reflectionListViewController = ReflectionListViewController(reflections:
        [Reflection(date: Date(fromString: "2001-01-01", format: .isoDate)!),
        Reflection(date: Date(fromString: "2001-01-01", format: .isoDate)!)])
    
    private lazy var greetingLabel: Label = {
        let label = Label(style: .title1)

        guard let user = user else { fatalError("No user was passed") }
        label.text = user.name.isEmpty ? "" : "Hi, " + user.name
        
        return label
    }()

    private lazy var reportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemSymbol: .chartBar), for: .normal)
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemSymbol: .gear), for: .normal)
        return button
    }()

    private lazy var footerView: UIStackView = {
        let footerView = UIStackView(arrangedSubviews: [reportButton, settingsButton])
        footerView.distribution = .equalSpacing
        return footerView
    }()

    // MARK: - Init
    
    convenience init(user: User) {
        self.init()
        self.user = user
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private methods

    private func setup() {
        view.backgroundColor = .systemBackground

        view.addSubviews(greetingLabel, reflectionListViewController.view, footerView)
        addChild(reflectionListViewController)

        reflectionListViewController.delegate = self

        greetingLabel.anchor(top: view.topAnchor,
                             leading: view.layoutMarginsGuide.leadingAnchor,
                             bottom: reflectionListViewController.view.topAnchor,
                             trailing: view.layoutMarginsGuide.trailingAnchor,
                             padding: .init(top: .spacingXXL, bottom: .spacingM))

        reflectionListViewController.view.anchor(top: greetingLabel.bottomAnchor,
                                              leading: view.leadingAnchor,
                                              bottom: nil,
                                              trailing: view.trailingAnchor,
                                              padding: .init(top: .spacingM, bottom: .spacingM))

        footerView.anchor(top: reflectionListViewController.view.bottomAnchor,
                          leading: view.layoutMarginsGuide.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.layoutMarginsGuide.trailingAnchor,
                          size: .init(width: 0, height: 50))
    }
}

extension HomeViewController: ReflectionListViewControllerDelegate {
    public func didSelectNewReflection(_ userId: String, viewController _: ReflectionListViewController) {
        
        let vc = MoodRatingViewController()
        let nc = NavigationController(rootViewController: vc)
        nc.hairlineIsHidden = true
        
        self.navigationController?.present(nc, animated: true, completion: nil)
        
        print("New reflection selected")
    }

    public func didSelectPastReflection(_ userId: String, viewController _: ReflectionListViewController) {
        print("Past reflection selected")
    }
}
