import Foundation

public protocol WeatherUseCase {
    func fetchWeather(cityName: String, completion: @escaping Completion<WeatherModel>)
    func fetchWeather(lat: String?, lon: String?, completion: @escaping Completion<WeatherModel>)
    func fetchWeatheForWeak(lat: String?, lon: String?, completion: @escaping Completion<[DayWeatherModel]>)
}

class WeatherUseCaseImpl: BaseUsecase {
    
    private enum Constants {
        static let apiKey = "88cfcfc71b57eea833bf1ccc523fc7b8"
        static let url = "https://api.openweathermap.org/data/2.5/weather?&appid"
        static let urlOneCall = "https://api.openweathermap.org/data/2.5/onecall?"
    }
    // MARK: Internal

    let secure: SecurePropertiesService

    // MARK: Lifecycle

    init(
        secure: SecurePropertiesService,
        unsecure: UnsecurePropertiesService
    ) {
        self.secure = secure
        super.init(unsecure: unsecure)
    }

    func fetchWeatheForWeak(lat: String?, lon: String?, completion: @escaping Completion<[DayWeatherModel]>) {
        guard
            let lon = lon != nil ? lon : unsecure.pull(key: .longitude),
            let lat = lat != nil ? lat : unsecure.pull(key: .latitude)
        else { return }
        let url = "\(Constants.urlOneCall)lat=\(lat)&lon=\(lon)&units=metric&appid=\(Constants.apiKey)"
        getWeatherForWeak(url: url, completion: completion)
    }

    func fetchWeather(cityName: String, completion: @escaping Completion<WeatherModel>) {
        let url = "\(Constants.url)=\(Constants.apiKey)&q=\(cityName)&units=metric"
        getWeather(url: url, completion: completion)
    }

    func fetchWeather(lat: String?, lon: String?, completion: @escaping Completion<WeatherModel>) {
        guard
            let lon = lon != nil ? lon : unsecure.pull(key: .longitude),
            let lat = lat != nil ? lat : unsecure.pull(key: .latitude)
        else { return }
        let url = "\(Constants.url)=\(Constants.apiKey)&lat=\(lat)&lon=\(lon)&units=metric"
        getWeather(url: url, completion: completion)
    }

    private func getWeather(url: String, completion: @escaping Completion<WeatherModel>) {
        guard let url = URL(string: url) else {
            completion(.error(""))
            return
        }

        URLSession(configuration: .default).dataTask(with: url) { data, _, _ in
            if let data {
                guard let item = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                    completion(.error(""))
                    return
                }
                let weather = WeatherModel(
                    cityName: item.name,
                    icon: item.weather.first?.icon,
                    temperature: item.main.temp, 
                    main: item.weather.first?.main
                )
                self.unsecure.push(key: .weatherModel, value: item)

                completion(.value(weather))
            } else {
                guard let model: WeatherData = self.unsecure.pull(key: .weatherModel) else {
                    completion(.error(""))
                    return
                }
                let weather = WeatherModel(
                    cityName: model.name,
                    icon: model.weather.first?.icon,
                    temperature: model.main.temp,
                    main: model.weather.first?.main
                )
                completion(.value(weather))
            }
        }.resume()
    }

    private func getWeatherForWeak(url: String, completion: @escaping Completion<[DayWeatherModel]>) {
        guard let url = URL(string: url) else {
            completion(.error(""))
            return
        }

        URLSession(configuration: .default).dataTask(with: url) { data, _, _ in
            if let data {
                guard let item = try? JSONDecoder().decode(ResultTemperature.self, from: data) else {
                    completion(.error(""))
                    return
                }
                let weather = item.daily.map {
                    DayWeatherModel(
                        day: TimeInterval($0.dt),
                        icon: $0.weather.first?.icon,
                        temperature: $0.temp.day
                    )
                }
                self.unsecure.push(key: .weatherForWeakModel, value: item)
                completion(.value(weather))

            } else {
                guard let model: ResultTemperature = self.unsecure.pull(key: .weatherForWeakModel) else {
                    completion(.error(""))
                    return
                }
                let weather = model.daily.map {
                    DayWeatherModel(
                        day: TimeInterval($0.dt),
                        icon: $0.weather.first?.icon,
                        temperature: $0.temp.day
                    )
                }
                completion(.value(weather))
            }
        }.resume()
    }
}

extension WeatherUseCaseImpl: WeatherUseCase {}

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct ResultTemperature: Codable {
    var daily: [Daily]

    mutating func sortDailyArray() {
        daily.sort { (day1, day2) -> Bool in
            return day1.dt < day2.dt
        }
    }
}

struct Daily: Codable {
    let dt: Int
    let temp: Temperature
    let weather: [Weather]

}

struct Temperature: Codable {
    let day: Double
}


public struct WeatherModel: Codable {
    let cityName: String
    var icon: String?
    let temperature: Double
    var temperatureString: String {
        String(format: "%0.0f", temperature)
    }
    var main: String?
    var description: String {
        guard main != "Rain" else {
            return "It's raining today, better take an umbrella"
        }
        switch temperature {
            case ...0:
                return "Today you need a down jacket"
            case 1...15:
                return "Today you can get by with a light jacket"
            case 16...:
                return "The weather will be hot today"
            default:
                return "The weather will be hot today"
        }
    }
    var isLocationsCanceled: Bool = true
    var imageUrl: URL? {
        guard let icon else { return nil }
        let iconId = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: iconId)
    }
}

public struct DayWeatherModel: Codable {
    let day: TimeInterval
    var dayString: String {
        let day = Date(timeIntervalSince1970: day)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: day)
    }
    var icon: String?
    let temperature: Double
    var temperatureString: String {
        String(format: "%0.0f", temperature)
    }
}
