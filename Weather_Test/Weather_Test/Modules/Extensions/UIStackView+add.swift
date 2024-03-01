import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview)
    }

    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach(addArrangedSubview)
    }

    func removeSubview(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeSubview(view: view)
        }
    }
}
