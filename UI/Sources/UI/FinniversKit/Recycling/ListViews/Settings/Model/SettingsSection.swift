//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

public struct SettingsSection {
    public let title: String?
    public var items: [SettingsViewCellModel]
    public let footerTitle: String?

    public init(title: String?, items: [SettingsViewCellModel], footerTitle: String? = nil) {
        self.title = title
        self.items = items
        self.footerTitle = footerTitle
    }
}
