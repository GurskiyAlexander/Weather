import UIKit

// MARK: - TabBarInputInterface

protocol TabBarInputInterface: BaseInputInterface {}

// MARK: - TabBarOutputInterface

protocol TabBarOutputInterface: BaseOutputInterface {
    func makeAllViewControllers() -> [UIViewController]
}

// MARK: - TabBarConfigModel

final class TabBarConfigModel: BaseConfigModel<
    TabBarInputInterface,
    TabBarOutputInterface
> {
    let mainUseCase: MainUseCase

    init(output: TabBarOutputInterface?, mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
        super.init(output: output)
    }
}
