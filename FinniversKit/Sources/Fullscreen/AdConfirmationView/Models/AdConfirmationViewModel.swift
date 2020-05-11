//
//  Copyright © 2019 FINN AS. All rights reserved.
//

public protocol AdConfirmationViewModel {
    var objectViewModel: AdConfirmationObjectViewModel { get set }
    var summaryViewModel: AdConfirmationSummaryViewModel? { get set }
    var feedbackViewModel: AdConfirmationFeedbackViewModel? { get set }
    var linkViewModel: AdConfirmationLinkViewModel? { get set }
    var completeButtonText: String { get set }
    var receiptInfo: String? { get set }
}
