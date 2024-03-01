// MARK: - ForecastInputInterface

protocol ForecastInputInterface: BaseInputInterface {}

// MARK: - ForecastOutputInterface

protocol ForecastOutputInterface: BaseOutputInterface {}

// MARK: - ForecastConfigModel

final class ForecastConfigModel: BaseConfigModel<
    ForecastInputInterface,
    ForecastOutputInterface
> {
    let mainUseCase: MainUseCase
    let weatherUseCase: WeatherUseCase

    init(output: ForecastOutputInterface?, mainUseCase: MainUseCase, weatherUseCase: WeatherUseCase) {
        self.mainUseCase = mainUseCase
        self.weatherUseCase = weatherUseCase
        super.init(output: output)
    }
}
