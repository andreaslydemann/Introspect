//
//  UserInterfaceStyle.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 11/05/2020.
//  Copyright © 2020 Andreas Lüdemann. All rights reserved.
//

import UIKit

enum UserInterfaceStyle: Int {
    case light = 1
    case dark = 2
}

extension UIWindow {
    @available(iOS 13.0, *)
    func setWindowUserInterfaceStyle(_ userInterfaceStyle: UserInterfaceStyle?) {
        #if swift(>=5.1)
        let uiUserInterfaceStyle: UIUserInterfaceStyle
        if let userInterfaceStyle = userInterfaceStyle {
            uiUserInterfaceStyle = userInterfaceStyle == .dark ? .dark : .light
        } else {
            uiUserInterfaceStyle = .unspecified
        }
        overrideUserInterfaceStyle = uiUserInterfaceStyle
        #endif
    }
}

extension Foundation.Notification.Name {
    static let didChangeUserInterfaceStyle = Foundation.Notification.Name("didChangeUserInterfaceStyle")
}
