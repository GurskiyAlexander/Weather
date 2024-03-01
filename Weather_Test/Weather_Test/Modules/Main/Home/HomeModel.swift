import UIKit

// MARK: - HomeViewModelInterface

protocol HomeViewModelInterface: RootViewModelProtocol {
    func serchWeather(with text: String?)
}

// MARK: - HomeViewModel

final class HomeViewModel: RootViewModel<
    HomeViewController,
    HomeConfigModel
> {
    
    override func viewLoaded() {
        super.viewLoaded()
        controller.isActivateLoader = true
        let lat = config.mainUseCase.lat
        let lon = config.mainUseCase.lon
        config.weatherUseCase.fetchWeather(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.controller.isActivateLoader = false

                switch result {
                    case .value(var value):
                        value.isLocationsCanceled = [.notDetermined, .denied].contains(self.config.mainUseCase.locateAuthorizationStatus)
                        self.controller.configure(with: value)
                    case .error(_):
                        print("error")
                }
            }
        }
    }

    override func viewAppeared() {
        super.viewAppeared()

        setup()
    }

    private func setup() {
        switch config.mainUseCase.locateAuthorizationStatus {
            case .notDetermined, .denied:
                print()
            default:
                break
        }
    }

}

// MARK: - HomeViewModelInterface

extension HomeViewModel: HomeViewModelInterface {
    func serchWeather(with text: String?) {
        guard let text else { return }
        controller.isActivateLoader = true
        config.weatherUseCase.fetchWeather(cityName: text) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.controller.isActivateLoader = false
                switch result {
                    case .value(var value):
                        value.isLocationsCanceled = [.notDetermined, .denied].contains(self.config.mainUseCase.locateAuthorizationStatus)
                        self.controller.configure(with: value)
                    case .error(_):
                        print("error")
                }
            }
        }
    }
}

// MARK: - HomeInputInterface

extension HomeViewModel: HomeInputInterface {}
