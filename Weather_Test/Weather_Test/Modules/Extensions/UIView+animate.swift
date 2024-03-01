import UIKit

public extension UIView {
    func animateClick(completion: @escaping () -> Void) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in completion()
            }
        }
    }
}
