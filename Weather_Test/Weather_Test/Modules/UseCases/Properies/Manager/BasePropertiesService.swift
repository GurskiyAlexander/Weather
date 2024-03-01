import Foundation

public class BasePropertiesService {
    private let manager: PropertiesManager

    init(type: PropertiesManager.`Type`) {
        manager = PropertiesManager(type: type)
    }

    func pull<Value: Codable>(key: String) -> Value? {
        manager[key]
    }

    func push<Value: Codable>(key: String, value: Value) {
        manager[key] = value
    }

    func clean(key: String) {
        manager.remove(for: key)
    }
}
