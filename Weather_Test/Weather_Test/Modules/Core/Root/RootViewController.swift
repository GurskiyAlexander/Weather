import UIKit

// MARK: - RootViewControllerProtocol

public protocol RootViewControllerProtocol {}

open class RootViewController<ViewModel>: UIViewController, ViewControllerInterface {
    public var viewModel: ViewModel!

    override open func viewDidLoad() {
        super.viewDidLoad()

        (viewModel as? RootViewModelProtocol)?.viewLoaded()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (viewModel as? RootViewModelProtocol)?.viewAppeared()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        (viewModel as? RootViewModelProtocol)?.viewDisappear()
    }

    open func addHideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    open func hideKeyboard() {
        view.endEditing(true)
    }
}

extension RootViewController: RootViewControllerProtocol {

}
