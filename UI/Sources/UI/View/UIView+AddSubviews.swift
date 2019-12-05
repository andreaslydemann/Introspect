import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
