// MARK: - HomeInputInterface

protocol HomeInputInterface: BaseInputInterface {}

// MARK: - HomeOutputInterface

protocol HomeOutputInterface: BaseOutputInterface {}

// MARK: - HomeConfigModel

final class HomeConfigModel: BaseConfigModel<
    HomeInputInterface,
    HomeOutputInterface
> {
    let mainUseCase: MainUseCase
    let weatherUseCase: WeatherUseCase

    init(output: HomeOutputInterface?, mainUseCase: MainUseCase, weatherUseCase: WeatherUseCase) {
        self.mainUseCase = mainUseCase
        self.weatherUseCase = weatherUseCase
        super.init(output: output)
    }
}
