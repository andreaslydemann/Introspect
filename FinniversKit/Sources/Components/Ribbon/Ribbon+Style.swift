//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public extension RibbonView {
    enum Style {
        case `default`
        case success
        case warning
        case error
        case disabled
        case sponsored

        var color: UIColor {
            switch self {
            case .default: return .bgSecondary
            case .success: return .bgSuccess
            case .warning: return .bgAlert
            case .error: return .bgCritical
            case .disabled: return .decorationSubtle
            case .sponsored: return .accentToothpaste
            }
        }

        var textColor: UIColor {
            switch self {
            case .default, .disabled: return .textPrimary
            default: return .textToast
            }
        }
    }
}
