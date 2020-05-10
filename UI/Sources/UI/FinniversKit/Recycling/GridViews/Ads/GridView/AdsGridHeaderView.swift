//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

class AdsGridHeaderView: UICollectionReusableView {
    var contentView: UIView? {
        willSet {
            contentView?.removeFromSuperview()
        }
        didSet {
            guard let contentView = contentView else {
                return // View was removed
            }

            addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.fillInSuperview()
        }
    }
}
