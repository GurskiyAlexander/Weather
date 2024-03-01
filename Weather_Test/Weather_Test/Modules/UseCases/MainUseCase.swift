import CoreLocation

public protocol MainUseCase {
    var locateAuthorizationStatus: CLAuthorizationStatus { get }
    var lon: String { get }
    var lat: String { get }

    func getLocation()
}

class MainUseCaseImpl: BaseUsecase {
    // MARK: Internal

    let secure: SecurePropertiesService
    var locateAuthorizationStatus: CLAuthorizationStatus {
        get { locationManager.authorizationStatus }
    }

    var lon: String {
        get {
            let lon: Double = unsecure.pull(key: .longitude) ?? -119.417931
            return String(lon)
        }
    }
    
    var lat: String {
        get {
            let lat: Double = unsecure.pull(key: .latitude) ?? 36.778259
            return String(lat)
        }
    }

    private let locationManager = CLLocationManager()

    // MARK: Lifecycle

    init(
        secure: SecurePropertiesService,
        unsecure: UnsecurePropertiesService
    ) {
        self.secure = secure
        super.init(unsecure: unsecure)
    }


}

extension MainUseCaseImpl: MainUseCase {
    func getLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
}

extension MainUseCaseImpl: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("authorizedWhenInUse")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        let latitude: Double = location.coordinate.latitude
        let longitude: Double = location.coordinate.longitude
        unsecure.push(key: .latitude, value: latitude)
        unsecure.push(key: .longitude, value: longitude)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
