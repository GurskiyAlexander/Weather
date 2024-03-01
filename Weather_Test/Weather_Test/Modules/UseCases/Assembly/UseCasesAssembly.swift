// MARK: - UseCasesAssembly

public protocol UseCasesAssembly {
    var mainUseCase: MainUseCase { get }
    var weatherUseCase: WeatherUseCase { get }
}

// MARK: - UseCasesAssemblyImpl

public class UseCasesAssemblyImpl: UseCasesAssembly {
    public lazy var mainUseCase: MainUseCase = MainUseCaseImpl(
        secure: propertiesAssembly.secureService,
        unsecure: propertiesAssembly.unsecureService
    )

    public lazy var weatherUseCase: WeatherUseCase = WeatherUseCaseImpl(
        secure: propertiesAssembly.secureService,
        unsecure: propertiesAssembly.unsecureService
    )

    private let propertiesAssembly: PropertiesAssembly

    public convenience init() {
        self.init(
            propertiesAssembly: PropertiesAssemblyImpl()
        )
    }

    init(propertiesAssembly: PropertiesAssembly) {
        self.propertiesAssembly = propertiesAssembly
    }
}
