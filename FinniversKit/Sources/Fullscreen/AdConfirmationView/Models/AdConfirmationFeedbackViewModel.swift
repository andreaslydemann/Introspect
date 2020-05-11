//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import Foundation

public protocol AdConfirmationFeedbackViewModel {
    var title: String { get set }
    var url: URL { get set }
    var ratingParameterKey: String { get set }
}
