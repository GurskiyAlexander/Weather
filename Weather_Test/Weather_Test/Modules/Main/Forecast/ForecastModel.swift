import UIKit

// MARK: - ForecastViewModelInterface

protocol ForecastViewModelInterface: RootViewModelProtocol {
    var dataSource: [DayCell.Model] { get set }
}

// MARK: - ForecastViewModel

final class ForecastViewModel: RootViewModel<
    ForecastViewController,
    ForecastConfigModel
> {
    var dataSource = [DayCell.Model]()
    
    override func viewLoaded() {
        fetchData()
    }

    private func fetchData() {
        controller.isActivateLoader = true
        let lat = config.mainUseCase.lat
        let lon = config.mainUseCase.lon
        config.weatherUseCase.fetchWeatheForWeak(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.controller.isActivateLoader = false

                switch result {
                    case .value(let value):
                        self.dataSource = value.map {
                            DayCell.Model(
                                title: $0.dayString,
                                subtitle: $0.temperatureString
                            )
                        }
                        self.controller.reloadData()
                    case .error(_):
                        print("error")
                }
            }
        }
    }
}

// MARK: - ForecastViewModelInterface

extension ForecastViewModel: ForecastViewModelInterface {}

// MARK: - ForecastInputInterface

extension ForecastViewModel: ForecastInputInterface {}
