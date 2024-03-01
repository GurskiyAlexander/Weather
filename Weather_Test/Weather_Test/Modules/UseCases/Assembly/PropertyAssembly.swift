// MARK: - PropertiesAssembly

protocol PropertiesAssembly {
    var secureService: SecurePropertiesService { get }
    var unsecureService: UnsecurePropertiesService { get }
}

// MARK: - PropertiesAssemblyImpl

class PropertiesAssemblyImpl: PropertiesAssembly {
    lazy var secureService: SecurePropertiesService = SecurePropertiesServiceImpl()
    lazy var unsecureService: UnsecurePropertiesService = UnsecurePropertiesServiceImpl()
}

