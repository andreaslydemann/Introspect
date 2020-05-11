//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public protocol MarketsGridViewModel {
    var iconImage: UIImage? { get }
    var showExternalLinkIcon: Bool { get }
    var title: String { get }
    var accessibilityLabel: String { get }
}

public extension MarketsGridViewModel {
    var accessibilityLabel: String {
        return title
    }
}
