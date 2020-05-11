//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public enum HappinessRating: Int, CaseIterable {
    case angry
    case dissatisfied
    case neutral
    case happy
    case love

    var image: UIImage {
        switch self {
        case .angry:
            return UIImage(named: .ratingFaceAngry)
        case .dissatisfied:
            return UIImage(named: .ratingFaceDissatisfied)
        case .neutral:
            return UIImage(named: .ratingFaceNeutral)
        case .happy:
            return UIImage(named: .ratingFaceHappy)
        case .love:
            return UIImage(named: .ratingFaceLove)
        }
    }
}
