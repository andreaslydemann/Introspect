//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

class CircleView: UIView, AttachableView {
    var attach: UIAttachmentBehavior?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .accentSecondaryBlue
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

    // MARK: - Override methods

    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}
