//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public struct PanelViewModel {
    let cornerRadius: CGFloat
    let text: String

    public init(cornerRadius: CGFloat = 8.0, text: String) {
        self.cornerRadius = cornerRadius
        self.text = text
    }
}
