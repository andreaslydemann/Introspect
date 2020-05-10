//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public protocol NotificationsGroupListViewModel {
    var attributedTitle: NSAttributedString { get }
    var timeAgo: String { get }
    var footerAction: String { get }
    var notifications: [NotificationsListViewModel] { get }
}

public protocol NotificationsListViewModel {
    var imagePath: String? { get }
    var imageSize: CGSize { get }
    var detail: String { get }
    var title: String { get }
    var price: String { get }
    var accessibilityLabel: String { get }
}

public extension NotificationsListViewModel {
    var accessibilityLabel: String {
        var message = detail
        message += ". " + title
        let cleanPrice = price.replacingOccurrences(of: " ", with: "")
        message += ". Pris: \(cleanPrice)kroner"
        return message
    }
}
