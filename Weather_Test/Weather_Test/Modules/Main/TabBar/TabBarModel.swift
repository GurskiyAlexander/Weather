import UIKit

// MARK: - TabBarViewModelInterface

protocol TabBarViewModelInterface: RootViewModelProtocol {
    var controllers: [UIViewController] { get }
}

// MARK: - TabBarViewModel

final class TabBarViewModel: RootViewModel<
    TabBarViewController,
    TabBarConfigModel
> {
    var controllers: [UIViewController] {
        get { config.output?.makeAllViewControllers() ?? [] }
    }
}

// MARK: - TabBarViewModelInterface

extension TabBarViewModel: TabBarViewModelInterface {}

// MARK: - TabBarInputInterface

extension TabBarViewModel: TabBarInputInterface {}
