//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public extension UIStackView {
    func removeArrangedSubviews() {
        for oldSubview in arrangedSubviews {
            removeArrangedSubview(oldSubview)
            oldSubview.removeFromSuperview()
        }
    }
}
