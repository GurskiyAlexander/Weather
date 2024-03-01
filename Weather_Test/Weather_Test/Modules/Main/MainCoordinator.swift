import UIKit

// MARK: - MainCoordinator

final class MainCoordinator: BaseCoordinator {
    private weak var assembly: MainAssembly?

    init(assembly: MainAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.rootNavigation)
    }

    override func start() {
        guard let item = self.assembly?.makeTabBar(output: self) else { return }
        self.navigationController.setViewControllers([item], animated: true)
    }
}

extension MainCoordinator: TabBarOutputInterface {
    func makeAllViewControllers() -> [UIViewController] {
        guard
            let home = assembly?.makeHome(output: self),
            let forecast = assembly?.makeForecast(output: self)
        else { return [] }
        return [home, forecast]
    }
}

extension MainCoordinator: HomeOutputInterface { }
extension MainCoordinator: ForecastOutputInterface { }


