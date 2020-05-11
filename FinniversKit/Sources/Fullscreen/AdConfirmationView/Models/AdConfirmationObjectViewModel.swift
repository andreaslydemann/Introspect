//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import Foundation

public protocol AdConfirmationObjectViewModel {
    var imageUrl: URL? { get set }
    var title: String { get set }
    var body: String? { get set }
}
