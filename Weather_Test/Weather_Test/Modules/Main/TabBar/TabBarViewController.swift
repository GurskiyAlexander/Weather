import UIKit
import SnapKit

// MARK: - TabBarBarViewControllerInterface

protocol TabBarViewControllerInterface: RootViewControllerProtocol {}

// MARK: - TabBarViewController

final class TabBarViewController: RootViewController<TabBarViewModelInterface> {
    private let mainTabBarController = CustomTabBarController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConctraints()
    }

    private func setupUI() {
        view.overrideUserInterfaceStyle = .light
        addChild(mainTabBarController)
        view.add(subviews: mainTabBarController.view)
        mainTabBarController.didMove(toParent: self)
        mainTabBarController.setViewControllers(viewModel.controllers, animated: true)
    }

    private func setupConctraints() {
        mainTabBarController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - TabBarViewControllerInterface

extension TabBarViewController: TabBarViewControllerInterface {}

extension TabBarViewController {}
