import UIKit

// MARK: - BaseAssembly

protocol MainAssemblyProtocol: BaseAssemblyProtocol {
    var rootAssembly: RootAssemblyProtocol { get }
    func makeTabBar(output: TabBarOutputInterface) -> TabBarViewController
    func makeHome(output: HomeOutputInterface) -> HomeViewController
    func makeForecast(output: ForecastOutputInterface) -> ForecastViewController
}

// MARK: - MainAssembly

public final class MainAssembly: BaseAssemblyProtocol {

    private var mainCoordinator: MainCoordinator!
    private let useCasesAssembly: UseCasesAssembly
    let rootAssembly: RootAssemblyProtocol
    let window: UIWindow

    public init(
        window: UIWindow,
        useCasesAssembly: UseCasesAssembly = UseCasesAssemblyImpl(),
        rootAssembly: RootAssemblyProtocol = RootAssembly()
    ) {
        self.useCasesAssembly = useCasesAssembly
        self.window = window
        self.rootAssembly = rootAssembly
    }

    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }

    public func coordinator() -> BaseCoordinator {
        mainCoordinator = MainCoordinator(assembly: self)
        return mainCoordinator
    }
}

// MARK: - MainAssembly

extension MainAssembly: MainAssemblyProtocol {
    func makeTabBar(output: TabBarOutputInterface) -> TabBarViewController {
        TabBarSceneAssembly(
            config: TabBarConfigModel(
                output: output, mainUseCase: useCasesAssembly.mainUseCase
            )
        ).controller!
    }

    func makeHome(output: HomeOutputInterface) -> HomeViewController {
        HomeSceneAssembly(
            config: HomeConfigModel(
                output: output,
                mainUseCase: useCasesAssembly.mainUseCase,
                weatherUseCase: useCasesAssembly.weatherUseCase
            )
        ).controller!
    }

    func makeForecast(output: ForecastOutputInterface) -> ForecastViewController {
        ForecastSceneAssembly(
            config: ForecastConfigModel(
                output: output,
                mainUseCase: useCasesAssembly.mainUseCase,
                weatherUseCase: useCasesAssembly.weatherUseCase
            )
        ).controller!
    }
}
