//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

extension BroadcastItem {
    struct Style {
        static let backgroundColor = UIColor.bgAlert
        static let containerCornerRadius: CGFloat = 8.0
        static let fontAttributes = [
            NSAttributedString.Key.font: UIFont.body,
            NSAttributedString.Key.foregroundColor: UIColor.textToast
        ]
        static let linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textAction]
    }
}
