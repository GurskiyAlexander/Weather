import UIKit

// MARK: - BaseCoordinator

open class BaseCoordinator: NSObject, Coordinator {
    public var onComplete: ((Coordinator) -> Void)?

    // MARK: - Properties

    private var _children: [Coordinator] = []

    public let navigationController: UINavigationController

    // MARK: - Coordinator Properties

    open var rootViewController: UIViewController {
        navigationController
    }

    open var children: [Coordinator] {
        _children
    }

    // MARK: - Constructor

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    open func add(child coordinator: Coordinator) {
        _children.append(coordinator)
    }

    open func remove(child coordinator: Coordinator) {
        _children = _children
            .filter { coordinator !== $0 }
    }

    // MARK: - Coordinator Methods

    open func start() {
        fatalError("This method must be overridden")
    }

    open func openPaywall() { }
}
