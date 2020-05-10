//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

enum AdsGridViewLayoutConfiguration {
    case small
    case medium
    case large

    static let mediumRange: Range<CGFloat> = (375.0 ..< 415.0)

    init(width: CGFloat) {
        switch width {
        case let width where width > AdsGridViewLayoutConfiguration.mediumRange.upperBound: self = .large
        case let width where width < AdsGridViewLayoutConfiguration.mediumRange.lowerBound: self = .small
        default: self = .medium
        }
    }

    var topOffset: CGFloat {
        switch self {
        case .large: return 10.0
        default: return 5.0
        }
    }

    var sidePadding: CGFloat {
        switch self {
        case .small: return 10.0
        case .medium: return 15.0
        case .large: return 25.0
        }
    }

    var lineSpacing: CGFloat {
        switch self {
        case .small: return 0.0
        default: return columnSpacing
        }
    }

    var columnSpacing: CGFloat {
        switch self {
        case .small: return 2.0
        case .medium: return 8.0
        case .large: return 12.0
        }
    }

    var numberOfColumns: Int {
        switch self {
        case .large:
            return 3
        default: return 2
        }
    }
}
