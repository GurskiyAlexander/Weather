import Foundation

// MARK: - SecureKeys

public enum SecureKeys: String {
    case password
    case userID
}

// MARK: - SecurePropertiesService

public protocol SecurePropertiesService {
    func pull<Value: Codable>(key: SecureKeys) -> Value?
    func push<Value: Codable>(key: SecureKeys, value: Value)
    func clean(key: SecureKeys)
}

// MARK: - SecurePropertiesServiceImpl

final class SecurePropertiesServiceImpl: BasePropertiesService, SecurePropertiesService {
    init() {
        super.init(type: .secure)
    }

    func pull<Value: Codable>(key: SecureKeys) -> Value? {
        super.pull(key: key.rawValue)
    }

    func push<Value: Codable>(key: SecureKeys, value: Value) {
        super.push(key: key.rawValue, value: value)
    }

    func clean(key: SecureKeys) {
        super.clean(key: key.rawValue)
    }
}
