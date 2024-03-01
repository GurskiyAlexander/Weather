import UIKit

extension UIView {
    func add(subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}

