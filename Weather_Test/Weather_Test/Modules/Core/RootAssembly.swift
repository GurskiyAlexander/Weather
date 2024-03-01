import UIKit

// MARK: - RootAssembly

public protocol RootAssemblyProtocol {
    var rootNavigation: UINavigationController { get }

    func makeNewNavigation() -> UINavigationController
}

// MARK: - RootAssembly

public class RootAssembly: RootAssemblyProtocol {
    public lazy var rootNavigation: UINavigationController = makeNewNavigation()


    public init() {}

    public func makeNewNavigation() -> UINavigationController {
        UINavigationController()
    }
}
