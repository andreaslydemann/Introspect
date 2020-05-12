//
//  NavigationController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 11/05/2020.
//  Copyright © 2020 Andreas Lüdemann. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    var hairlineIsHidden: Bool = false {
        didSet {
            if hairlineIsHidden {
                navigationBar.shadowImage = UIImage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
        updateColors(animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(userInterfaceStyleDidChange), name: .didChangeUserInterfaceStyle, object: nil)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            #if swift(>=5.1)
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                updateColors(animated: true)
            }
            #endif
        }
    }

    @objc private func userInterfaceStyleDidChange() {
        updateColors(animated: true)
    }

    private func updateColors(animated: Bool) {
        func setupColors() {
            let barTintColor: UIColor = .bgPrimary
            let tintColor: UIColor = .textAction

            navigationBar.barTintColor = barTintColor
            navigationBar.tintColor = tintColor
            navigationBar.layoutIfNeeded()
        }

        if animated {
            UIView.animate(withDuration: 0.3) {
                setupColors()
            }
        } else {
            setupColors()
        }
    }
}
