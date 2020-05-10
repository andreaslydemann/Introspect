//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

extension TextField {
    public enum InputType {
        case normal
        case email
        case phoneNumber
        case password
        case multiline

        var isSecureMode: Bool {
            switch self {
            case .password: return true
            default: return false
            }
        }

        var keyBoardStyle: UIKeyboardType {
            switch self {
            case .email: return .emailAddress
            case .phoneNumber: return .phonePad
            default: return .default
            }
        }

        var returnKeyType: UIReturnKeyType {
            switch self {
            case .email: return .next
            case .normal, .phoneNumber, .password, .multiline: return .done
            }
        }

        var textContentType: UITextContentType? {
            switch self {
            case .email:
                return .emailAddress
            case .phoneNumber:
                return .telephoneNumber
            case .password:
                return .password
            case .normal, .multiline:
                return nil
            }
        }
    }
}
