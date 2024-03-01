import Foundation

// MARK: - SecureKeys

enum UnsecureKeys: String {
    case latitude
    case longitude
    case weatherModel
    case weatherForWeakModel
}

// MARK: - SecurePropertiesService

protocol UnsecurePropertiesService {
    func pull<Value: Codable>(key: UnsecureKeys) -> Value?
    func push<Value: Codable>(key: UnsecureKeys, value: Value)
    func clean(key: UnsecureKeys)
}

// MARK: - SecurePropertiesServiceImpl

final class UnsecurePropertiesServiceImpl: BasePropertiesService, UnsecurePropertiesService {
    init() {
        super.init(type: .unsecure)
    }

    func pull<Value: Codable>(key: UnsecureKeys) -> Value? {
        super.pull(key: key.rawValue)
    }

    func push<Value: Codable>(key: UnsecureKeys, value: Value) {
        super.push(key: key.rawValue, value: value)
    }

    func clean(key: UnsecureKeys) {
        super.clean(key: key.rawValue)
    }
}
