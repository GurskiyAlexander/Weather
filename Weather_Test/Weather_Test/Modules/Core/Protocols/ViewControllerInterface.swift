import UIKit

// MARK: - ViewControllerInterface

public protocol ViewControllerInterface: AnyObject {
    associatedtype ViewModel

    var viewModel: ViewModel! { get set }

    init()
}
